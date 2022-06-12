# frozen_string_literal: true

module Product
  module Virtual
    module_function

    RECURSION_LIMIT = 100

    RECURSIVE_COMPONENTS = <<-SQL.squish
      WITH RECURSIVE product_components AS (
        SELECT p.*, 0 level, 1 multiplier FROM products p WHERE id = :id UNION
          SELECT
            p.*, level + 1 level, multiplier * pr.quantity multiplier
          FROM product_relations pr
          JOIN product_components pa ON pa.id = pr.parent_id
          JOIN products p ON p.id = pr.child_id
          ORDER BY level ASC
          LIMIT :limit
      )
      SELECT * FROM product_components WHERE mode = :mode
    SQL

    def base_components_query(product, mode: 0)
      product.class.connection.exec_query(
        product.class.sanitize_sql([
          RECURSIVE_COMPONENTS,
          { id: product.id, limit: RECURSION_LIMIT, mode: }
        ])
      ).to_a
    end

    def base_components(product)
      base_components_query(product).to_h do |res|
        res.delete("level")
        mul = res.delete("multiplier")
        [Core::Product.new(res), mul]
      end
    end

    def recursion_limit?(product)
      max = base_components_query(product, mode: 1).map { |x| x["level"] }.max
      (max || 0).next == RECURSION_LIMIT
    end

    def how_many_virtual_products_from(virtual, available)
      qnts =
        virtual.base_components.map do |component, ammount|
          available[component].div(ammount)
        end
      qnts.min
    end
  end
end

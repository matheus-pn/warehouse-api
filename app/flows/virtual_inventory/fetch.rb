# frozen_string_literal: true

module VirtualInventory
  module Fetch
    module_function

    FETCHING_SQL = <<-SQL.squish
      SELECT p.*, SUM(ip.quantity) quantity
      FROM inventory_products ip
      INNER JOIN inventories iv ON iv.id = ip.inventory_id
      INNER JOIN products p ON p.id = ip.product_id
      INNER JOIN virtual_inventory_relations ir ON ir.child_id = iv.id
        AND ir.parent_id = :id
      GROUP BY p.id
    SQL

    def fetching_query(virtual_inventory)
      virtual_inventory.class.connection.exec_query(
        virtual_inventory.class.sanitize_sql([
          FETCHING_SQL, { id: virtual_inventory.id }
        ])
      ).to_a
    end

    def product_pool(virtual_inventory)
      pool_hash =
        fetching_query(virtual_inventory).to_h do |res|
          quantity = res.delete("quantity")
          [Core::Product.new(res), quantity]
        end
      ::Product::Pool.new(pool_hash:)
    end
  end
end

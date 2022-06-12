# frozen_string_literal: true

module Product
  class Pool
    attr_accessor :id_product_table, :id_quantity_table, :source

    def initialize(pool_hash: {})
      @source = pool_hash
      @id_product_table = {}
      @id_quantity_table = Hash.new(0)

      pool_hash.each do |product, quantity|
        @id_product_table[product.id] = product
        @id_quantity_table[product.id] = quantity
      end
    end

    def +(other)
      iqt = @id_quantity_table.merge(other.id_quantity_table) { |_, a, b| a + b }
      ipt = @id_product_table.merge(other.id_product_table)
      source = {}
      iqt.each do |id, quantity|
        source[ipt[id]] = quantity
      end
      self.class.allocate.assign(source, ipt, iqt)
    end

    def assign(source, id_product_table, id_quantity_table)
      @source = source
      @id_product_table = id_product_table
      @id_quantity_table = id_quantity_table
      self
    end

    def inspect
      @id_quantity_table.inspect
    end

    def [](product)
      @id_quantity_table[product.id]
    end

    def to_h
      @source
    end
  end
end

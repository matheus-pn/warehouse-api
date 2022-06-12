# frozen_string_literal: true

module Core
  class Product < ApplicationRecord
    belongs_to :enterprise
    has_many :inventory_products, inverse_of: :product, dependent: :destroy
    has_many :inventories, through: :inventory_products, inverse_of: :products
    enum mode: { physical: 0, virtual: 1 }

    def inventories=(*)
      raise NotImplementedError, "Dangerous fucking method"
    end

    def base_components
      ::Product::Virtual.base_components(self)
    end

    def recursion_limit?
      ::Product::Virtual.recursion_limit?(self)
    end

    def how_many_virtual_products_from(pool = {})
      ::Product::Virtual.how_many_virtual_products_from(self, pool)
    end
  end
end

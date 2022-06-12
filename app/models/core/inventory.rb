# frozen_string_literal: true

module Core
  class Inventory < ApplicationRecord
    include Taggable

    belongs_to :division
    has_many :virtual_inventory_relations, dependent: :destroy, foreign_key: :child_id, inverse_of: :child
    has_many :inventory_products, inverse_of: :inventory, dependent: :destroy
    has_many :products, through: :inventory_products, inverse_of: :inventories

    def products=(*)
      raise NotImplementedError, "Dangerous fucking method"
    end

    def fetch_enterprise; end

    def product_pool
      pool_hash =
        inventory_products
        .includes(:product)
        .group_by(&:product)
        .transform_values { |vs| vs.sum(&:quantity) }

      ::Product::Pool.new(pool_hash:)
    end
  end
end

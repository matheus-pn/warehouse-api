# frozen_string_literal: true

module Core
  class VirtualInventory < ApplicationRecord
    include Taggable
    has_many :virtual_inventory_relations, dependent: :destroy, foreign_key: :parent_id, inverse_of: :parent
    has_many :inventories, through: :virtual_inventory_relations, source: :child

    belongs_to :division

    def inventories=(*)
      raise NotImplementedError, "Dangerous fucking method"
    end

    def product_pool
      ::VirtualInventory::Fetch.product_pool(self)
    end
  end
end

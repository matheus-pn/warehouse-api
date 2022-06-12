# frozen_string_literal: true

module Core
  class VirtualInventoryRelation < ApplicationRecord
    belongs_to :parent, class_name: "Core::VirtualInventory"
    belongs_to :child, class_name: "Core::Inventory"
  end
end

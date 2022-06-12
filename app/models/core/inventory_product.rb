# frozen_string_literal: true

module Core
  class InventoryProduct < ApplicationRecord
    belongs_to :product
    belongs_to :inventory

    def increase!(qnt)
      self.class.connection.exec_update(
        self.class.sanitize_sql([
          "UPDATE inventory_products SET quantity = quantity + :increment WHERE id = :id",
          { id:, increment: qnt }
        ])
      )
    end

    def decrease!(qnt)
      increase!(-qnt)
    end
  end
end

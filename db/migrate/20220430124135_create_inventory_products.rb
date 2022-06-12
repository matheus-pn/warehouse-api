# frozen_string_literal: true

class CreateInventoryProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_products do |t|
      t.references :product, null: false, foreign_key: true
      t.references :inventory, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end

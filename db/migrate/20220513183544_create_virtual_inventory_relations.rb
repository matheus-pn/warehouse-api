# frozen_string_literal: true

class CreateVirtualInventoryRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :virtual_inventory_relations do |t|
      t.integer :parent_id, null: false, index: true
      t.integer :child_id, null: false, index: true

      t.timestamps
    end
    add_foreign_key :virtual_inventory_relations, :virtual_inventories, column: :parent_id
    add_foreign_key :virtual_inventory_relations, :inventories, column: :child_id
  end
end

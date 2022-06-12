# frozen_string_literal: true

class CreateProductRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :product_relations do |t|
      t.integer :mode, null: false, default: 0
      t.integer :parent_id, null: false, index: true
      t.integer :child_id, null: false, index: true
      t.integer :quantity, default: 1, null: false

      t.timestamps
    end
    add_foreign_key :product_relations, :products, column: :parent_id
    add_foreign_key :product_relations, :products, column: :child_id
  end
end

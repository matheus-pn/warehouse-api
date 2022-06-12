# frozen_string_literal: true

class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.references :division, null: false, foreign_key: true
      t.string :name, null: false, default: ""

      t.timestamps
    end
  end
end

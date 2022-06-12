# frozen_string_literal: true

class CreateVirtualInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :virtual_inventories do |t|
      t.references :division, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end

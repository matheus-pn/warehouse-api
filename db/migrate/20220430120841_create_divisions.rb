# frozen_string_literal: true

class CreateDivisions < ActiveRecord::Migration[7.0]
  def change
    create_table :divisions do |t|
      t.references :parent, polymorphic: true, index: true, null: false
      t.string :name, null: false, default: ""

      t.timestamps
    end
  end
end

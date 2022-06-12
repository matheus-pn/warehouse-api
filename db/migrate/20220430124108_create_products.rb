# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.references :enterprise, foreign_key: true, null: false
      t.integer :mode, null: false, default: 0
      t.string :name, null: false, default: ""
      t.string :code, null: false, default: ""

      t.timestamps
      t.index %i[enterprise_id code], unique: true
    end
  end
end

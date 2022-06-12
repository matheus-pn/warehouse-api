# frozen_string_literal: true

class CreateEnterprises < ActiveRecord::Migration[7.0]
  def change
    create_table :enterprises do |t|
      t.string :name, null: false, default: ""

      t.timestamps
    end
  end
end

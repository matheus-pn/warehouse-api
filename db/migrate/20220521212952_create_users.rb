# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.references :enterprise, null: false, foreign_key: true
      t.string :password_digest, null: false
      t.string :username, null: false

      t.timestamps
      t.index :username, unique: true
    end
  end
end

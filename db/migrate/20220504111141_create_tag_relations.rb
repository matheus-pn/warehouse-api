# frozen_string_literal: true

class CreateTagRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :tag_relations do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :owner, polymorphic: true, index: true, null: false

      t.timestamps
    end
  end
end

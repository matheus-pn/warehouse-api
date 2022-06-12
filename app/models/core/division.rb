# frozen_string_literal: true

module Core
  class Division < ApplicationRecord
    belongs_to :parent, polymorphic: true
    has_many :divisions, as: :parent, inverse_of: :parent, dependent: :destroy
    has_many :inventories, dependent: :destroy

    DIVISIONS_RECURSIVE_DOWN = <<-SQL.squish
    WITH RECURSIVE recursive_divisions AS (
      SELECT d.id, 0 level FROM divisions d WHERE id = :id UNION
      SELECT d.id, level + 1 level FROM divisions d
      JOIN recursive_divisions rd ON (
        rd.id = d.parent_id AND d.parent_type = 'Core::Division'
      )
      LIMIT 100
    )
    SELECT d.* FROM recursive_divisions rd
    JOIN divisions d ON d.id = rd.id
    SQL

    ENTERPRISE_ID = <<-SQL.squish
    WITH RECURSIVE recursive_divisions_up AS (
      SELECT d.parent_id, d.id, d.parent_type, 0 level FROM divisions d WHERE id = :id UNION
      SELECT d.parent_id, d.id, d.parent_type, level + 1 level FROM divisions d
      JOIN recursive_divisions_up rd ON (
        rd.parent_id = d.id AND rd.parent_type = 'Core::Division'
      )
      LIMIT 100
    )
    SELECT e.id FROM recursive_divisions_up rd
    JOIN enterprises e ON e.id = rd.parent_id
    AND rd.parent_type = 'Core::Enterprise'
    SQL

    def enterprise_id
      Core::Division.connection.exec_query(
        Core::Division.sanitize_sql([
          ENTERPRISE_ID, { id: }
        ])
      ).to_a.first["id"]
    end

    # TODO: Remove format
    def recursive(format: :model)
      Core::Division.connection.exec_query(
        Core::Division.sanitize_sql([
          DIVISIONS_RECURSIVE_DOWN, { id: }
        ])
      ).to_a.map do |a|
        case format
        when :model then Core::Division.new(a)
        when :json then a
        end
      end
    end
  end
end

# frozen_string_literal: true

module Api
  class EnterprisesController < ActionController::API
    include UserAuth
    include Common

    def show
      render(json: build_payload)
    end

    def build_payload
      user, enterprise, divisions, inventories, virtual_inventories =
        load_data
      user = user.as_json(except: %i[password_digest created_at updated_at])
      divisions = without_timestamps(divisions).each do |div|
        div["parent_id"] = nil if div.delete("parent_type") == "Core::Enterprise"
      end
      enterprise          = without_timestamps(enterprise)
      inventories         = without_timestamps(inventories)
      virtual_inventories = without_timestamps(virtual_inventories)
      { user:, enterprise:, divisions:, inventories:, virtual_inventories: }
    end

    def load_data
      enterprise  = current_user.enterprise
      divisions   = enterprise.root_division.recursive
      inventories = Core::Inventory.where(division_id: divisions.pluck(:id)).load_async
      virtual_inventories = Core::VirtualInventory.where(division_id: divisions.pluck(:id)).load_async

      [current_user, enterprise, divisions, inventories, virtual_inventories]
    end
  end
end

# frozen_string_literal: true

module Api
  class InventoryProductsController < ActionController::API
    include UserAuth
    include Common

    def index
      inventory = find_inventory
      return not_authorized! if inventory.division.enterprise_id != current_user.enterprise_id

      render(json: payload(inventory))
    end

    def find_inventory
      if params[:virtual].present?
        Core::VirtualInventory.find(params[:inventory_id])
      else
        Core::Inventory.find(params[:inventory_id])
      end
    end

    def payload(inventory)
      product_pool = inventory.product_pool
      pool_hash = product_pool.to_h
      pool_hash.map do |product, quantity|
        product.virtual? and
          quantity += product.how_many_virtual_products_from(product_pool)

        { product: without_timestamps(product), quantity: }
      end
    end
  end
end

# frozen_string_literal: true

module Api
  class ProductsController < ActionController::API
    include UserAuth
    include Common

    def index
      enterprise = current_user.enterprise
      render(json: without_timestamps(enterprise.products))
    end
  end
end

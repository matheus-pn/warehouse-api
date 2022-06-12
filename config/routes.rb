# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  namespace :api do
    post :login,  to: "auth#login"
    post :logout, to: "auth#logout"
    resource :enterprise, only: %i[show]
    resources :products, only: %i[index create update destroy]
    resources :product_relations, only: %i[create update destroy]
    resources :divisions, only: %i[create update destroy]
    resources :inventories, only: %i[create update destroy] do
      resources :inventory_products, only: %i[index create update]
    end
  end
end

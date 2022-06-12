# frozen_string_literal: true

module Core
  class ProductRelation < ApplicationRecord
    belongs_to :parent, class_name: "Core::Product"
    belongs_to :child, class_name: "Core::Product"
    enum mode: { alias: 0, component: 1 }
  end
end

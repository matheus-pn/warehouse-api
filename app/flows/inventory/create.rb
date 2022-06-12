# frozen_string_literal: true

module Inventory
  module Create
    module_function
    extend CreateBase

    def _one(attributes)
      Core::Inventory.create(attributes)
    end
  end
end

# frozen_string_literal: true

module Division
  module Create
    module_function
    extend CreateBase

    def _one(attributes)
      Core::Division.create(attributes)
      # create_virtual_inventory(division)
    end

    def create_virtual_inventory(division)
      division.inventories.create(
        name: division.name.to_s,
        mode: :virtual
      )
    end
  end
end

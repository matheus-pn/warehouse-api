# frozen_string_literal: true

module Enterprise
  module Create
    module_function
    extend CreateBase

    def _one(attributes)
      enterprise = Core::Enterprise.create(attributes)
      create_root_division(enterprise)
      enterprise
    end

    def create_root_division(enterprise)
      Division::Create.one(
        parent: enterprise,
        name: enterprise.name.to_s
      )
    end
  end
end

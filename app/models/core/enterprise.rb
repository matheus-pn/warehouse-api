# frozen_string_literal: true

module Core
  class Enterprise < ApplicationRecord
    has_many :divisions, as: :parent, inverse_of: :parent, dependent: :destroy
    has_many :products, inverse_of: :enterprise, dependent: :destroy
    has_many :users, inverse_of: :enterprise, dependent: :destroy, class_name: "Interface::User"

    def root_division
      divisions.find_by(parent_type: self.class.name)
    end
  end
end

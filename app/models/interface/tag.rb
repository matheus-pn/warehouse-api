# frozen_string_literal: true

module Interface
  class Tag < ApplicationRecord
    has_many :tag_relations, dependent: :destroy
    has_many :owners, through: :tag_relations, inverse_of: :tags

    def owners=(*)
      raise NotImplementedError, "Dangerous f-ing method"
    end
  end
end

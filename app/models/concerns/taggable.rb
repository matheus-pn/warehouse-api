# frozen_string_literal: true

module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :tag_relations, as: :owner, dependent: :destroy
    has_many :tags, through: :tag_relations, dependent: :destroy

    def tags=(*)
      raise NotImplementedError, "Dangerous f-ing method"
    end
  end
end

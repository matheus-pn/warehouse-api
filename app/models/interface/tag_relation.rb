# frozen_string_literal: true

module Interface
  class TagRelation < ApplicationRecord
    belongs_to :tag
    belongs_to :owner, polymorphic: true
  end
end

# frozen_string_literal: true

module Interface
  class UserSession < ApplicationRecord
    belongs_to :user
    scope :expired, -> { where("expires_at < ?", Time.current) }

    def expired?
      expires_at < Time.current
    end
  end
end

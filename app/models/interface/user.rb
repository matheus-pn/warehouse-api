# frozen_string_literal: true

module Interface
  class User < ApplicationRecord
    has_secure_password
    belongs_to :enterprise, class_name: "Core::Enterprise"
    has_many :user_sessions, dependent: :destroy
  end
end

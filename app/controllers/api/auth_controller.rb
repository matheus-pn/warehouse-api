# frozen_string_literal: true

module Api
  class AuthController < ActionController::API
    include UserAuth
    skip_before_action :authenticate_user, except: :logout

    def logout
      current_session.delete
      head :ok
    end

    def login
      username, password = params.values_at(:username, :password)
      user = Interface::User.find_by(username:)
      return login_failure! if user.blank?

      if user.authenticate(password)
        login_success!(user)
      else
        login_failure!
      end
    end

    def login_failure!
      render(json: { error: "Wrong username/password" }, status: :unauthorized)
    end

    def login_success!(user)
      user.user_sessions.expired.exists? and
        user.user_sessions.expired.delete_all

      session = Interface::UserSession.create!(
        token: SecureRandom.hex(128),
        expires_at: 1.day.from_now,
        user:
      )
      render(json: { token: session.token })
    end
  end
end

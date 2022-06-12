# frozen_string_literal: true

module UserAuth
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user
    attr_reader :current_user, :current_session
  end

  def authenticate_user
    session = fetch_session
    return not_authorized! if session.blank?
    return session_expired! if session.expired?

    @current_session = session
    @current_user = current_session.user
  end

  def not_authorized!
    head(
      :unauthorized,
      "WWW-Authenticate": "Bearer"
    )
  end

  def fetch_session
    Interface::UserSession.find_by(token: session_token)
  end

  def session_expired!
    render(json: { error: "Session Expired" }, status: :unauthorized)
  end

  def session_token
    auth = request.headers[:authorization].presence || params[:sessionToken] || ""
    auth.delete_prefix("Bearer ").presence
  end
end

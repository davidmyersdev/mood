module SetUser
  extend ActiveSupport::Concern

  included do
    before_action :fetch_session_user
    after_action :store_session_user
  end

  def current_user
    @current_user ||= fetch_session_user || User.new
  end

  def fetch_session_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def store_session_user
    return unless current_user.persisted?

    session[:user_id] = current_user.id
  end
end

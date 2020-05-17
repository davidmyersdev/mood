class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :authenticate_by_session
  before_action :link_subscription_to_user
  after_action :set_session_subscription
  after_action :set_session_user

  private

  def authenticate_by_nonce
    return redirect_to root_path unless notification

    notification.update!(nonce: nil)

    @subscription = notification.subscription
    @current_user = subscription.user
  end

  def authenticate_by_session
    @current_user = User.find(session[:user_id])
    @subscription = current_user.subscriptions.kept.find_by(id: session[:subscription_id])
  rescue ActiveRecord::RecordNotFound => _error
    redirect_to root_path
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) || User.new
  end

  def link_subscription_to_user
    return unless current_user.persisted?
    return unless subscription.persisted?
    return if subscription.user.present?

    subscription.update!(user: current_user)
  end

  def notification
    @notification ||= Notification.find_by(
      id: params_notifications[:notification_id],
      nonce: params_notifications[:notification_nonce],
    )
  end

  def params_notifications
    @params_notifications ||= params.permit(
      :notification_id,
      :notification_nonce,
    )
  end

  def set_session_subscription
    return unless subscription.persisted?

    session[:subscription_id] = subscription.id
  end

  def set_session_user
    return unless current_user.persisted?

    session[:user_id] = current_user.id
  end

  def subscription
    @subscription ||= Subscription.find_by(id: session[:subscription_id]) || Subscription.new
  end
end

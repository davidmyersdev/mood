class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :authenticate_by_session
  before_action :link_subscription_to_user
  after_action :set_session_subscription
  after_action :set_session_user

  private

  def authenticate_by_nonce
    return head :forbidden unless notification

    notification.update!(nonce: nil)

    @subscription = notification.push_subscription
    @current_user = subscription.user
  end

  def authenticate_by_session
    @current_user = User.find(session[:user_id])
    @subscription = current_user.push_subscriptions.find_by(id: session[:push_subscription_id])
  rescue ActiveRecord::RecordNotFound => _e
    head :forbidden
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
      nonce: params_notifications[:nonce],
    )
  end

  def params_notifications
    @params_notifications ||= params.permit(
      :nonce,
      :notification_id,
    )
  end

  def set_session_subscription
    return unless subscription.persisted?

    session[:push_subscription_id] = subscription.id
  end

  def set_session_user
    return unless current_user.persisted?

    session[:user_id] = current_user.id
  end

  def subscription
    @subscription ||= PushSubscription.find_by(id: session[:push_subscription_id]) || PushSubscription.new
  end
end

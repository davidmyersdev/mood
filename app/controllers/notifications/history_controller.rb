module Notifications
  class HistoryController < ApplicationController
    skip_before_action :authenticate_by_session
    before_action :authenticate_by_subscription

    helper_method :notification_responses

    def index
    end

    private

    def authenticate_by_subscription
      @subscription = PushSubscription.find_by!(id: session[:push_subscription_id])
    rescue ActiveRecord::RecordNotFound => _e
      head :forbidden
    end

    def current_user_notifications
      return unless current_user.persisted?

      current_user.notifications.presence
    end

    def notification_responses
      NotificationResponse
        .where(notification: notifications)
        .where(created_at: 2.weeks.ago..Time.current)
        .order(created_at: :asc)
    end

    def notifications
      current_user_notifications || subscription_notifications || []
    end

    def subscription_notifications
      return unless subscription.persisted?

      subscription.notifications.presence
    end
  end
end

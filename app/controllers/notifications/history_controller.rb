module Notifications
  class HistoryController < ApplicationController
    skip_before_action :authenticate_by_token
    before_action :authenticate_by_session

    def index
      render json: notification_responses
    end

    private

    def authenticate_by_session
      head :forbidden unless session[:push_subscription_id]

      @push_subscription = PushSubscription.find(session[:push_subscription_id])
    rescue ActiveRecord::RecordNotFound => error
      head :forbidden
    end

    def push_subscription
      @push_subscription ||= PushSubscription.new
    end

    def notification_responses
      NotificationResponse.where(notification: push_subscription.notifications)
    end
  end
end

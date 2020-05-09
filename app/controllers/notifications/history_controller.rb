module Notifications
  class HistoryController < ApplicationController
    helper_method :notification_responses

    def index
    end

    private

    def notification_responses
      NotificationResponse
        .where(notification: current_user.notifications)
        .where(created_at: 2.weeks.ago..Time.current)
        .order(created_at: :asc)
    end
  end
end

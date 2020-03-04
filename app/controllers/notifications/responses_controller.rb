module Notifications
  class ResponsesController < ApplicationController
    skip_before_action :authenticate_by_token
    before_action :authenticate_by_nonce

    helper_method :moods
    helper_method :notification_nonce

    def new
      notification.regenerate_nonce!
    end

    def create
      NotificationResponse.create!(
        notification: notification,
        data: {
          choices: response_params[:choices],
        },
        notes: response_params[:notes],
      )

      session[:push_subscription_id] = notification.push_subscription_id

      redirect_to notification_history_index_path
    rescue ActiveRecord::RecordInvalid => e
      render json: e.message, status: :bad_request
    end

    private

    def authenticate_by_nonce
      return head :forbidden unless notification

      notification.update!(nonce: nil)
    end

    def moods
      Mood.all
    end

    def notification
      @notification ||= Notification.where(
        id: response_params[:notification_id],
        nonce: response_params[:nonce],
      ).first
    end

    def notification_nonce
      notification.nonce
    end

    def response_params
      params.permit(:nonce, :notes, :notification_id, choices: [])
    end
  end
end

module Notifications
  class ResponsesController < ApplicationController
    skip_before_action :authenticate_by_token, only: [:create]
    before_action :authenticate_by_nonce

    def create
      response = NotificationResponse.create!(
        notification: notification,
        data: {
          choice: response_params[:choice],
        },
        mood: Mood.find_by(slug: response_params[:choice]),
      )

      render json: response, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: e.message, status: :bad_request
    end

    private

    def authenticate_by_nonce
      return head :forbidden unless notification

      notification.update!(nonce: nil)
    end

    def notification
      @notification ||= Notification.where(
        id: response_params[:notification_id],
        nonce: response_params[:nonce],
      ).first
    end

    def response_params
      params.permit(:choice, :nonce, :notification_id)
    end
  end
end

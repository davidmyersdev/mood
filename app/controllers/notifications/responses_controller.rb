module Notifications
  class ResponsesController < ApplicationController
    skip_before_action :authenticate_by_session
    before_action :authenticate

    helper_method :moods

    def new
    end

    def create
      NotificationResponse.create!(
        notification: notification,
        data: {
          choices: response_params[:choices],
        },
        notes: response_params[:notes],
      )

      redirect_to history_index_path
    rescue ActiveRecord::RecordInvalid => e
      render json: e.message, status: :bad_request
    end

    private

    def authenticate
      return authenticate_by_nonce if notification.present?

      authenticate_by_session
    end

    def moods
      Mood.all
    end

    def response_params
      params.permit(:notes, choices: [])
    end
  end
end

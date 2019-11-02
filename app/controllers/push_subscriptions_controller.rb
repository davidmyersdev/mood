class PushSubscriptionsController < ApplicationController
  skip_before_action :authenticate_by_token, only: [:create]

  def create
    subscription = PushSubscription.create!(subscription: push_subscription_params)

    render json: subscription, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: e.message, status: :bad_request
  end

  private

  def push_subscription_params
    params.permit(
      :endpoint,
      :expirationTime,
      keys: [
        :p256dh,
        :auth,
      ],
    )
  end
end

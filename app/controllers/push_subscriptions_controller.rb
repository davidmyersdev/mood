class PushSubscriptionsController < ApplicationController
  skip_before_action :authenticate_by_token, only: [:create]

  def create
    subscription = PushSubscription.create!(
      max_actions: push_subscription_params[:max_actions],
      data: push_subscription_params[:subscription],
    )

    render json: subscription, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: e.message, status: :bad_request
  end

  private

  def push_subscription_params
    params.permit(
      :max_actions,
      subscription: [
        :endpoint,
        :expirationTime,
        keys: [
          :auth,
          :p256dh,
        ],
      ],
    )
  end
end

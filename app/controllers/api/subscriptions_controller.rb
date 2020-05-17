module Api
  class SubscriptionsController < ApiController
    def create
      subscription = current_user.subscriptions.find_or_create_by!(data: data) do |subscription|
        subscription.max_actions = max_actions
        subscription.user = current_user
      end

      render json: subscription, status: :created
    rescue ActiveRecord::RecordInvalid => error
      Raven.capture_exception(error)

      render json: error.message, status: :bad_request
    end

    private

    def data
      subscription_params[:subscription]
    end

    def max_actions
      subscription_params[:max_actions]
    end

    def subscription_params
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
end

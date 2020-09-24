module Api
  class SubscriptionsController < ApiController
    def create
      subscription = current_user.subscriptions.find_or_create_by!(data: subscription_params[:subscription]) do |subscription|
        subscription.description = subscription_params[:description]
        subscription.max_actions = subscription_params[:max_actions]
        subscription.user = current_user
        subscription.user_agent = subscription_params[:user_agent]
      end

      if subscription.description.nil? && subscription_params[:description].present?
        subscription.update!(description: subscription_params[:description])
      end

      if subscription.user_agent.nil? && subscription_params[:user_agent].present?
        subscription.update!(user_agent: subscription_params[:user_agent])
      end

      render json: subscription, status: :created
    rescue ActiveRecord::RecordInvalid => error
      Raven.capture_exception(error)

      render json: error.message, status: :bad_request
    end

    private

    def subscription_params
      params.permit(
        :description,
        :max_actions,
        :user_agent,
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

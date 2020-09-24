class SubscriptionsController < ApplicationController
  helper_method :subscriptions

  def index
  end

  private

  def subscriptions
    @subscriptions ||= current_user.subscriptions.kept
  end
end

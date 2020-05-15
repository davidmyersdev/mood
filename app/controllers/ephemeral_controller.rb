class EphemeralController < ApplicationController
  skip_before_action :authenticate_by_session, only: [:authenticate_by_notification, :log_me_in]
  before_action :authenticate_by_nonce, only: [:authenticate_by_notification]

  def authenticate_by_notification
    redirect_to dashboard_index_path
  end

  def log_me_in
  end

  def notify_me
    return redirect_to root_path unless current_user.persisted?

    current_user.push_subscriptions.find_each do |subscription|
      Notifications::MoodService.notify(subscription)
    end

    redirect_to dashboard_index_path
  end
end

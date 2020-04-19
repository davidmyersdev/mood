class EphemeralController < ApplicationController
  skip_before_action :authenticate_by_session, only: [:authenticate_by_notification, :log_me_in]
  before_action :authenticate_by_nonce, only: [:authenticate_by_notification]

  def authenticate_by_notification
    redirect_to history_index_path
  end

  def log_me_in
  end

  def notify_me
    return head :forbidden unless subscription.persisted?

    Notifications::MoodService.notify(subscription)

    head :ok
  end
end

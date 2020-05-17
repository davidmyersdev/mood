class EntriesController < ApplicationController
  helper_method :entries, :moods, :notification

  def index
  end

  def new
    notification.regenerate_nonce! if notification
  end

  def create
    current_user.entries.create!(
      data: {
        choices: entry_params[:choices],
      },
      notes: entry_params[:notes],
      notification: notification,
    )

    redirect_to entries_path
  rescue ActiveRecord::RecordInvalid => error
    Raven.capture_exception(error)

    redirect_to new_entry_path
  end

  private

  def authenticate
    if notification.present?
      notification.update!(nonce: nil)

      @current_user = notification.subscription.user
    end

    super
  end

  def entries
    @entries ||= Entry
      .where(user: current_user)
      .where(created_at: 2.weeks.ago..Time.current)
      .order(created_at: :asc)
  end

  def entry_params
    params.permit(:notes, choices: [])
  end

  def moods
    Mood.all
  end

  def notification
    @notification ||= Notification.find_by(
      id: notification_params[:notification_id],
      nonce: notification_params[:notification_nonce],
    )
  end

  def notification_params
    @notification_params ||= params.permit(
      :notification_id,
      :notification_nonce,
    )
  end
end

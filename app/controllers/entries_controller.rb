class EntriesController < ApplicationController
  helper_method :end_date, :start_date
  helper_method :entries, :entry, :moods, :notification

  def index
  end

  def edit
  end

  def new
    notification.regenerate_nonce! if notification
  end

  def update
    entry.update!(
      data: {
        choices: entry_params[:choices],
      },
      notes: entry_params[:notes],
    )

    redirect_to entries_path
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

  def end_date
    @end_date ||= if entry_params[:end_date].present?
      Time.parse(entry_params[:end_date]).end_of_day
    else
      Time.current
    end
  rescue ArgumentError => error
    Raven.capture_exception(error)

    Time.current
  end

  def entries
    current_user.entries.where(created_at: start_date..end_date).order(created_at: :asc)
  end

  def entry
    @entry ||= current_user.entries.find(entry_params[:id])
  end

  def entry_params
    params.permit(:id, :end_date, :notes, choices: [])
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

  def start_date
    @start_date ||= (end_date - 13.days).beginning_of_day
  end
end

class EntriesController < ApplicationController
  skip_before_action :authenticate_by_session
  before_action :authenticate

  helper_method :entries, :moods, :notification

  def index
  end

  def new
    notification.regenerate_nonce! if notification
  end

  def create
    Entry.create!(
      data: {
        choices: entry_params[:choices],
      },
      notes: entry_params[:notes],
      notification: notification,
      user: current_user,
    )

    redirect_to entries_path
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error('Entry Creation Error')
    Rails.logger.error(e)

    redirect_to new_entry_path
  end

  private

  def authenticate
    return authenticate_by_nonce if notification.present?

    authenticate_by_session
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
end

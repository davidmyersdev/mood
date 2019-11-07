class PushSubscription < ApplicationRecord
  belongs_to :user, optional: true
  has_many :notifications

  validates :data, presence: true, uniqueness: true

  def last_successful_notification
    notifications.successful.order(:dispatched_at).last
  end
end

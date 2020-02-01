class NotificationResponse < ApplicationRecord
  belongs_to :mood, optional: true
  belongs_to :notification

  validates :data, presence: true
end

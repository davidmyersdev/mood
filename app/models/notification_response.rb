class NotificationResponse < ApplicationRecord
  belongs_to :mood
  belongs_to :notification

  validates :data, presence: true
end

class NotificationResponse < ApplicationRecord
  belongs_to :notification

  validates :data, presence: true
end

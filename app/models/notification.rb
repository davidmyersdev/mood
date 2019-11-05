class Notification < ApplicationRecord
  belongs_to :push_subscription

  validates :data, presence: true
end

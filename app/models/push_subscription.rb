class PushSubscription < ApplicationRecord
  belongs_to :user, optional: true
  has_many :notifications

  validates :data, presence: true, uniqueness: true
end

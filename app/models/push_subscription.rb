class PushSubscription < ApplicationRecord
  belongs_to :user

  validates :subscription, presence: true, uniqueness: true
end

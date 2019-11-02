class PushSubscription < ApplicationRecord
  validates :subscription, presence: true, uniqueness: true
end

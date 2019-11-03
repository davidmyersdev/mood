class PushSubscription < ApplicationRecord
  belongs_to :user, optional: true

  validates :subscription, presence: true, uniqueness: true
end

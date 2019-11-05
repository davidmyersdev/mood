class PushSubscription < ApplicationRecord
  belongs_to :user, optional: true

  validates :data, presence: true, uniqueness: true
end

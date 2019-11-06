class Notification < ApplicationRecord
  belongs_to :push_subscription

  before_validation :set_nonce, on: :create

  validates :data, presence: true

  private

  def set_nonce
    self.nonce = SecureRandom.hex(32)
  end
end

class Notification < ApplicationRecord
  belongs_to :push_subscription
  has_many :notification_responses

  before_validation :set_nonce, on: :create

  validates :data, presence: true

  scope :successful, -> { where.not(dispatched_at: nil) }

  def dispatched_after?(time)
    return false unless dispatched_at

    dispatched_at > time
  end

  def regenerate_nonce!
    set_nonce
    save!
  end

  private

  def set_nonce
    self.nonce = SecureRandom.hex(32)
  end
end

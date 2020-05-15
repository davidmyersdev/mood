class User < ApplicationRecord
  has_secure_password

  has_many :entries
  has_many :push_subscriptions
  has_many :notifications, through: :push_subscriptions

  validates :email, presence: true, uniqueness: true

  def as_json(options = {})
    options[:except] ||= []
    options[:except] << :password_digest

    super(options)
  end
end

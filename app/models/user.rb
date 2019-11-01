class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  def as_json(options = {})
    options[:except] ||= []
    options[:except] << :password_digest

    super(options)
  end
end

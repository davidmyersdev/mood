class Mood < ApplicationRecord
  has_many :notification_responses

  validates :slug, presence: true
  validates :description, presence: true

  def self.for(slug)
    slug = slug.downcase

    find_or_create_by(slug: slug, description: slug.to_s.titleize) if /\A\w+\z/.match?(slug)
  end
end

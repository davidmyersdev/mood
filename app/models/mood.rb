class Mood < ApplicationRecord
  has_many :notification_responses

  validates :slug, presence: true
  validates :description, presence: true

  def self.happy
    where(slug: :happy).first_or_create! do |mood|
      mood.update!(description: '😄 Happy')
    end
  end

  def self.meh
    where(slug: :meh).first_or_create! do |mood|
      mood.update!(description: '😐 Meh')
    end
  end

  def self.sad
    where(slug: :sad).first_or_create! do |mood|
      mood.update!(description: '😔 Sad')
    end
  end

  def self.upset
    where(slug: :upset).first_or_create! do |mood|
      mood.update!(description: '😠 Upset')
    end
  end
end

class Entry < ApplicationRecord
  belongs_to :mood, optional: true
  belongs_to :notification, optional: true
  belongs_to :user, optional: true

  validates :data, presence: true
end

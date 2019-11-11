class AddMoodReferenceToNotificationResponses < ActiveRecord::Migration[5.2]
  def change
    add_reference :notification_responses, :mood, foreign_key: true
  end
end

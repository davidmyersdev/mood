class CreateNotificationResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :notification_responses do |t|
      t.references :notification, foreign_key: true
      t.jsonb :data, null: false, index: true
      t.timestamps
    end
  end
end

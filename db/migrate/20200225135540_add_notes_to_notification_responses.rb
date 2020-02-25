class AddNotesToNotificationResponses < ActiveRecord::Migration[5.2]
  def change
    add_column :notification_responses, :notes, :text
  end
end

class RenameNotificationResponsesToEntries < ActiveRecord::Migration[5.2]
  def change
    rename_table :notification_responses, :entries
  end
end

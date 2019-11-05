class RenameSubscriptionToDataOnPushSubscriptions < ActiveRecord::Migration[5.2]
  def change
    rename_column :push_subscriptions, :subscription, :data
  end
end

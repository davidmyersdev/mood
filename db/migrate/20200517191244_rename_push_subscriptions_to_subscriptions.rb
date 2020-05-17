class RenamePushSubscriptionsToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    rename_table :push_subscriptions, :subscriptions
    rename_column :notifications, :push_subscription_id, :subscription_id
  end
end

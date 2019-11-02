class AddMaxActionsToPushSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :push_subscriptions, :max_actions, :integer
  end
end

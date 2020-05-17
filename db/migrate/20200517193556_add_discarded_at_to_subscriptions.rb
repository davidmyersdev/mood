class AddDiscardedAtToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :discarded_at, :datetime, index: true
  end
end

class AddNonceToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :nonce, :string
  end
end

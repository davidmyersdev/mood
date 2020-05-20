class AddDeviceInformationToSubscriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :user_agent, :string
    add_column :subscriptions, :description, :string
  end
end

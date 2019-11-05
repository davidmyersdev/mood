class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :push_subscription, foreign_key: true
      t.jsonb :data, null: false, index: true
      t.datetime :dispatched_at
      t.timestamps
    end
  end
end

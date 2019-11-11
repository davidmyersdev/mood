class CreateMoods < ActiveRecord::Migration[5.2]
  def change
    create_table :moods do |t|
      t.string :slug, null: false, index: { unique: true }
      t.string :description, null: false
      t.timestamps
    end
  end
end

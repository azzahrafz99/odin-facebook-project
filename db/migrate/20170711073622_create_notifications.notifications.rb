# This migration comes from notifications (originally 20160328045436)
class CreateNotifications < ActiveRecord::Migration[4.2]
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false
      t.integer :actor_id
      t.string :notify_type, null: false
      t.datetime :read_at
      t.timestamps
    end

    add_index :notifications, [:user_id, :notify_type]
    add_index :notifications, [:user_id]
  end
end

class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string :notice
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps
    end
  end
end

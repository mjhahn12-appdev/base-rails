class AddLocationToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :location, :string
  end
end

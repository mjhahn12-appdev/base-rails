class AddPlanTimeToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :plan_time, :datetime
  end
end

class ChangeStatusToBeBooleanInPlans < ActiveRecord::Migration[6.0]
  def change
      change_column :plans, :status, :boolean
  end
end

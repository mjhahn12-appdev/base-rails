class AddRecipientStatusToPlans < ActiveRecord::Migration[6.0]
  def change
    add_column :plans, :recipient_status, :boolean
  end
end

class AddSenderStatusToPlans < ActiveRecord::Migration[6.0]
  def change
    add_column :plans, :sender_status, :boolean
  end
end

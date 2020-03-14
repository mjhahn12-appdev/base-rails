class AddRecipientNumberToPlans < ActiveRecord::Migration[6.0]
  def change
    add_column :plans, :recipient_number, :string
  end
end

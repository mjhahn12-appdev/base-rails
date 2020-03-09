class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.string :status
      t.datetime :plan_time
      t.string :location

      t.timestamps
    end
  end
end

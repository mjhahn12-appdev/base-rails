# == Schema Information
#
# Table name: plans
#
#  id               :integer          not null, primary key
#  location         :string
#  plan_time        :datetime
#  recipient_number :string
#  status           :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  recipient_id     :integer
#  sender_id        :integer
#

class Plan < ApplicationRecord
  def sender_username
    return User.where({ :id => sender_id}).pluck( :username )
  end

  def recipient_username
    return User.where({ :id => recipient_id }).pluck( :username )
  end
end

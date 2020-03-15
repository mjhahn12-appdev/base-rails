# == Schema Information
#
# Table name: plans
#
#  id           :integer          not null, primary key
#  location     :string
#  plan_time    :datetime
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#

class Plan < ApplicationRecord
  def recipient
    return User.where({ :id=> recipient_id}).pluck(:username)
  end

  def sender
    return User.where({ :id => sender_id}).pluck(:username)
  end
end

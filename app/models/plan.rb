# == Schema Information
#
# Table name: plans
#
#  id               :integer          not null, primary key
#  location         :string
#  plan_time        :datetime
#  recipient_status :boolean
#  sender_status    :boolean
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  recipient_id     :integer
#  sender_id        :integer
#

class Plan < ApplicationRecord

  belongs_to :sender, :class_name => "User"
  belongs_to :recipient, :class_name => "User"

  def recipient
    return User.where({ :id=> recipient_id}).pluck(:username)[0]
  end

  def sender
    return User.where({ :id => sender_id}).pluck(:username)[0]
  end
end

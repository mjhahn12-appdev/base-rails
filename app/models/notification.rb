# == Schema Information
#
# Table name: notifications
#
#  id           :integer          not null, primary key
#  location     :string
#  notice       :string
#  plan_time    :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#

class Notification < ApplicationRecord
  def sender
    return User.where({ :id => self.sender_id }).pluck(:username )[0]
  end

  def recipient
    return User.where({ :id => self.recipient_id }).pluck(:username )[0]
  end
end

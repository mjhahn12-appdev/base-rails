# == Schema Information
#
# Table name: notifications
#
#  id           :integer          not null, primary key
#  notice       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#

class Notification < ApplicationRecord
  
end

class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where({ :sender_id => @current_user.id }).or(Notification.where({ :recipient_id => @current_user.id })).order({ :created_at => :desc })

    render({ :template => "notifications/index.html.erb" })
  end

end

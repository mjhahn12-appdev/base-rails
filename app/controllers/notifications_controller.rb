class NotificationsController < ApplicationController
  def index
    @notifications = Notification.all.order({ :created_at => :desc })

    render({ :template => "notifications/index.html.erb" })
  end

  def destroy
    the_id = params.fetch("path_id")
    @notification = Notification.where({ :id => the_id }).at(0)

    @notification.destroy

    redirect_to("/notifications", { :notice => "Notification deleted successfully."} )
  end
end

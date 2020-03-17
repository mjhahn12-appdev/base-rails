class PlansController < ApplicationController
  def home
    render({ :template => "plans/home.html.erb"})
  end

  def index
    @plans = Plan.where({ :sender_id => @current_user.id }).order({ :plan_time => :desc })

    render({ :template => "plans/index.html.erb" })
  end

  def invited_plans
    @plans = Plan.where({ :recipient_id => @current_user.id }).order({ :plan_time => :desc })

    render({ :template => "plans/invited_plans.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    @plan = Plan.where({:id => the_id }).at(0)

    render({ :template => "plans/show.html.erb" })
  end

  def create
    @plan = Plan.new

    sender_username = params["query_sender_id"]
    @plan.sender_id = User.where({ :username => sender_username }).pluck(:id)[0]
    @plan.status = true
    recipient_username = params["query_recipient_id"]
    @plan.recipient_id = User.where({ :username => recipient_username }).pluck(:id)[0]
    @plan.plan_time = params.fetch("query_plan_time")
    @plan.location = params.fetch("query_location")

    if @plan.valid?
      @plan.save
      redirect_to("/plans", { :notice => "Plan created successfully." })
    else
      redirect_to("/plans", { :notice => "Plan failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @plan = Plan.where({ :id => the_id }).at(0)

    sender_username = params["query_sender_id"]
    @plan.sender_id = User.where({ :username => sender_username }).pluck(:id)[0]
    recipient_username = params["query_recipient_id"]
    @plan.recipient_id = User.where({ :username => recipient_username }).pluck(:id)[0]
    @plan.status = true
    @plan.plan_time = params.fetch("query_plan_time")
    @plan.location = params.fetch("query_location")

    if @plan.valid?
      @plan.save
      redirect_to("/plans/#{@plan.id}", { :notice => "Plan updated successfully."} )
    else
      redirect_to("/plans/#{@plan.id}", { :alert => "Plan failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @plan = Plan.where({ :id => the_id }).at(0)
    
    if (@plan.sender_status != false) or (@plan.recipient_status != false)
      if (@plan.sender_id == @current_user.id)
        @plan.sender_status = false
        @plan.save
      elsif (@plan.recipient_id == @current_user.id)
        @plan.recipient_status = false
        @plan.save
      end
    end

    if (@plan.sender_status == false) and (@plan.recipient_status == false)
      @notification = Notification.new
      @notification.notice = "Your <%= @plan.plan_time %> plan at <%= @plan.location %> has been cancelled."
      @notification.sender_id = @plan.sender_id
      @notification.recipient_id = @plan.recipient_id
      @notification.save
    
      @plan.destroy
      redirect_to("/plans", {:notice => "Plan is deleted!"})
    else 
      redirect_to("/plans/#{@plan.id}", {:notice => "Plan is still on!"})
    end
  end
end
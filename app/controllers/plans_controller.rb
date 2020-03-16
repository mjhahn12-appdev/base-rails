class PlansController < ApplicationController
  def home
    render({ :template => "plans/home.html.erb"})
  end
  def index
    @plans = Plan.where({ :sender_id => @current_user.id }).order({ :plan_time => :asc })

    render({ :template => "plans/index.html.erb" })
  end

  def invited_plans
    @plans = Plan.where({ :recipient_id => @current_user.id }).order({ :plan_time => :asc })

    render({ :template => "plans/invited_plans.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    @plan = Plan.where({:id => the_id }).at(0)

    render({ :template => "plans/show.html.erb" })
  end

  def create
    @plan = Plan.new

    @plan.sender = params["query_sender_id"]
    @plan.sender_id = User.where({ :username => @plan.sender }).pluck(:id)[0]
    @plan.status = "TRUE"
    @plan.recipient = params["query_recipient_id"]
    @plan.recipient_id = User.where({ :username => @plan.recipient }).pluck(:id)[0]
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
    @plan.status = "TRUE"
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
    if @plan.sender_id == @current_user.id
      return @plan.sender_status == "FALSE"
    elsif @plan.recipient_id == @current_user.id
      return @plan.recipient_status == "FALSE"
    end
    if @plan.sender_status == "FALSE" && @plan.recipient_status == "FALSE"
      redirect_to("/plans", { :notice => "Plan deleted successfully."} )
    else
      redirect_to("/plans", { :notice => "Plan is still on!"})
    end
  end
end

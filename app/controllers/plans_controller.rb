class PlansController < ApplicationController
  def index
    @plans = Plan.all.order({ :created_at => :desc })

    render({ :template => "plans/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    @plan = Plan.where({:id => the_id }).at(0)

    render({ :template => "plans/show.html.erb" })
  end

  def create
    @plan = Plan.new
    @plan.sender_id = params.fetch("query_sender_id")
    @plan.recipient_id = params.fetch("query_recipient_id")
    @plan.status = params.fetch("query_status")
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

    @plan.sender_id = params.fetch("query_sender_id")
    @plan.recipient_id = params.fetch("query_recipient_id")
    @plan.status = params.fetch("query_status")
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

    @plan.destroy

    redirect_to("/plans", { :notice => "Plan deleted successfully."} )
  end
end

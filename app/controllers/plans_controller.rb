class PlansController < ApplicationController
  def home
    render({ :template=> "plans/home.html.erb"})
  end
  def index
    @plans = Plan.all.order({ :created_at => :desc })

    render({ :template => "plans/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    @plan = Plan.where({:id => the_id }).at(0)

    render({ :template => "plans/show.html.erb" })
  end

  def makeit
      render({ :template=> "plans/makeit.html.erb"})
  end

  def create
    @plan = Plan.new
    recipientusername = params.fetch("query_recipient_username")
    @plan.recipient_id = User.where({ :username => recipientusername })
    @plan.recipient_number = params.fetch("query_recipient_phonenumber")
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
    if session[:user_id] == sender_id
      @plan.sender_status == false
    else
      @plan.recipient_status == false 
    end
    @plan.save

    @plan.each do |plan|
    @plan.each do |comparePlan|
      if plan.status == comparePlan.status && plan.deleted? && comparePlan.deleted && plan.receiver_id != comparePlan.receiver_id
        @plan.status == false
        redirect_to("/plans", { :notice => "Plan broken successfully."} )
      else
        redirect_to("/plans", { :notice => "Plan is still on."})
      end
    end
    end
  end
end

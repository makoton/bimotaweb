# -*- encoding : utf-8 -*-
class Admin::VehicleOrdersController < Admin::BaseController
  before_filter :load_vehicle
  before_filter :load_order, only: [:destroy, :add_comment, :new_task, :commit_new_task, :delete_task, :add_consumable_supply, :commit_supply, :add_part_supply, :labor_cost_form, :commit_labor_cost, :finish_task, :task_details]

  def index
    @page_title = "Ordenes para #{@vehicle.full_name} - #{@vehicle.user ? @vehicle.user.name.titleize : 'Sin Dueño'}"
    @orders = @vehicle.orders.page params[:page]
  end

  def new
    @page_title = 'Nuevo Vehículo'
    @order = @vehicle.orders.new
    @order.created_by = current_user.name
    @order.user = @vehicle.user ? @vehicle.user : nil
    @order.current_state = Order::STATUS_NEW
    @order.save

    redirect_to admin_vehicle_order_path(@vehicle, @order)
  end

  def show
    @order = @vehicle.orders.includes(:comments).find(params[:id])
    @page_title = "Orden ##{@order.uuid}"
  end

  def destroy
    @order.destroy

    flash[:info] = 'La Orden fue eliminada.'
    redirect_to admin_vehicle_orders_path(@vehicle)
  end

  def add_comment
    @comment = @order.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    @order.reload
    @comment.reload
  end

  def new_task
    @task = @order.tasks.new
  end

  def commit_new_task
    @task = @order.tasks.new(task_params)
    @task.created_by = current_user.name
    @result = @task.save
  end

  def add_consumable_supply
    @task = @order.tasks.find(params[:task])
    render partial: 'consumable_supply_form'
  end

  def add_part_supply
    @task = @order.tasks.find(params[:task])
    render partial: 'part_supply_form'
  end

  def commit_supply
    task = @order.tasks.find(params[:task])
    supply = Supply.find(params[:supply])
    supply.assign_to_task(task, params[:quantity])
    render 'commit_new_task'
  end

  def get_supply_stock
    supply = Supply.find(params[:supply])
    render text: supply.supply_items.available.count
  end

  def labor_cost_form
    @task = @order.tasks.find(params[:task])
    render partial: 'labor_form'
  end

  def commit_labor_cost
    task = @order.tasks.find(params[:task])
    task.labor_cost = params[:amount]
    task.save
    task.recalc!
    render 'commit_new_task'
  end

  def finish_task
    task = @order.tasks.find(params[:task])
    task.finish!
    redirect_to admin_vehicle_order_path(@vehicle, @order)
  end

  def task_details
    @task = @order.tasks.find(params[:task])
    @consumables = @task.supplies_by_type('ConsumableSupply')
    @parts = @task.supplies_by_type('PartSupply')
    render partial: 'task_detail'
  end

  def delete_task
    task = @order.tasks.find(params[:task_id])
    if task.destroy
      flash[:success] = 'Se eliminó el trabajo.'
    else
      flash[:error] = 'Ocurrió un problema eliminando el trabajo, inténtalo de nuevo'
    end

    redirect_to admin_vehicle_order_path(@vehicle, @order)
  end

  private

  def order_params
    params.require(:order).permit(:vehicle_id, :user_id, :created_by)
  end

  def comment_params
    params.require(:comment).permit(:order_id, :user_id, :content, :task_id)
  end

  def task_params
    params.require(:task).permit(:order_id, :title, :created_by, :labor_cost, :price, :observations, :status)
  end

  def load_vehicle
    @vehicle = BikeVehicle.includes(:orders, :user, :bike_brand).find(params[:vehicle_id])
  end

  def load_order
    @order = @vehicle.orders.find(params[:id])
  end

end
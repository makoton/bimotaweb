# -*- encoding : utf-8 -*-
class Admin::VehicleOrdersController < Admin::BaseController
  before_filter :load_vehicle
  before_filter :load_order, only: [:destroy, :start, :finish, :add_comment, :commit_new_task, :delete_task, :delete_comment, :add_consumable_supply, :remove_part_supply, :remove_consumable_supply, :commit_supply, :commit_remove_supply, :add_part_supply, :labor_cost_form, :commit_labor_cost, :finish_task, :task_details, :pending_task]
  before_filter :load_task, except: [:index, :new, :show, :destroy, :start, :finish, :commit_new_task, :add_comment, :get_consumed_supplies, :get_supply_stock, :delete_comment]

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
    @task = @order.tasks.new
  end

  def destroy
    @order.destroy

    flash[:info] = 'La Orden fue eliminada.'
    redirect_to admin_vehicle_orders_path(@vehicle)
  end

  def start
    @order.start!(current_user)
    redirect_to admin_vehicle_order_path(@vehicle, @order)
  end

  def finish
    @order.finish!(current_user)
    redirect_to admin_vehicle_order_path(@vehicle, @order)
  end

  def add_comment
    @comment = @order.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    @order.reload
    @comment.reload
  end

  def commit_new_task
    @task = @order.tasks.new(task_params)
    @task.created_by = current_user.name
    @result = @task.save
  end

  def remove_consumable_supply
    render partial: 'remove_consumable_supply_form'
  end

  def remove_part_supply
    render partial: 'remove_part_supply_form'
  end

  def add_consumable_supply
    render partial: 'consumable_supply_form'
  end

  def add_part_supply
    render partial: 'part_supply_form'
  end

  def commit_remove_supply
    supply = Supply.find(params[:supply])
    supply.unassign_from_task(@task, params[:quantity])
    render 'commit_new_task'
  end

  def commit_supply
    supply = Supply.find(params[:supply])
    supply.assign_to_task(@task, params[:quantity])
    render 'commit_new_task'
  end

  def get_consumed_supplies
    render text: Task.find(params[:task]).supply_items.where(supply_id: params[:supply]).count
  end

  def get_supply_stock
    supply = Supply.find(params[:supply])
    render text: supply.available_supplies_count
  end

  def labor_cost_form
    render partial: 'labor_form'
  end

  def commit_labor_cost
    @task.labor_cost = params[:amount]
    @task.save
    @task.recalc!
    render 'commit_new_task'
  end

  def finish_task
    @task.finish!
    redirect_to admin_vehicle_order_path(@vehicle, @order)
  end

  def pending_task
    @task.pending!
    redirect_to admin_vehicle_order_path(@vehicle, @order)
  end

  def task_details
    @consumables = @task.supplies_by_type('ConsumableSupply')
    @parts = @task.supplies_by_type('PartSupply')
    render partial: 'task_detail'
  end

  def delete_task
    if @task.destroy
      flash[:success] = 'Se eliminó el trabajo.'
    else
      flash[:error] = 'Ocurrió un problema eliminando el trabajo, inténtalo de nuevo'
    end

    redirect_to admin_vehicle_order_path(@vehicle, @order)
  end

  def delete_comment
    comment = Comment.find(params[:comment_id])
    if comment.destroy
      flash[:success] = 'Se eliminó el comentario.'
    else
      flash[:error] = 'Ocurrió un problema eliminando el comentario, inténtalo de nuevo'
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

  def load_task
    @task = @order.tasks.find(params[:task])
  end

end
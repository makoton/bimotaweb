# -*- encoding : utf-8 -*-
class Admin::VehicleOrdersController < Admin::BaseController
  before_filter :load_vehicle
  before_filter :load_order, only: [:destroy, :add_comment, :new_task, :commit_new_task]

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
    if @task.save

    else

    end
  end

  private

  def order_params
    params.require(:order).permit(:vehicle_id, :user_id, :created_by)
  end

  def comment_params
    params.require(:comment).permit(:order_id, :user_id, :content)
  end

  def task_params
    params.require(:task).permit(:order_id, :user_id, :content)
  end

  def load_vehicle
    @vehicle = BikeVehicle.includes(:orders, :user, :bike_brand).find(params[:vehicle_id])
  end

  def load_order
    @order = @vehicle.orders.find(params[:id])
  end

end
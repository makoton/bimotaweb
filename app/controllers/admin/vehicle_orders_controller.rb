# -*- encoding : utf-8 -*-
class Admin::VehicleOrdersController < Admin::BaseController
  before_filter :load_vehicle

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

  def edit
    @order = @vehicle.orders.find(params[:id])
  end

  def update
    @order = @vehicle.orders.find(params[:id])
    if @order.update!(order_params)
      flash[:success] = 'Se modificó correctamente la orden'
      redirect_to admin_vehicle_order_path(@vehicle, @order)
    end
  end

  def add_comment
    @order = Order.find_by_uuid(params[:uuid])
    @comment = @order.comments.new(comment_params)

  end

  private

  def order_params
    params.require(:order).permit(:vehicle_id, :user_id, :created_by)
  end

  def comment_params
    params.require(:comment).permit(:order_id, :user_id, :content)
  end

  def load_vehicle
    @vehicle = BikeVehicle.includes(:orders, :user, :bike_brand).find(params[:vehicle_id])
  end

end
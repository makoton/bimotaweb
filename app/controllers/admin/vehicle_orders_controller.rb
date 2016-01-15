# -*- encoding : utf-8 -*-
class Admin::VehicleOrdersController < Admin::BaseController
  before_filter :load_vehicle

  def index
    @page_title = "Ordenes para #{@vehicle.full_name}"
    @orders = @vehicle.orders
  end

  def new
    @page_title = 'Nuevo Vehículo'
    @order = @vehicle.orders.new
  end

  def create
    @order = @vehicle.orders.new(order_params)

    if @order.save
      flash[:success] = 'Orden guardada con éxito!'
      redirect_to admin_vehicle_order_path(@vehicle, @order)
    end
  end

  def show
    @order = @vehicle.orders.find(params[:id])
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

  private

  def order_params
    params.require(:order).permit(:vehicle_id, :current_state, :year, :license_plate, :chassis_number, :kilometraje)
  end

  def load_vehicle
    @vehicle = BikeVehicle.includes(:orders, :user, :bike_brand).find(params[:vehicle_id])
  end

end
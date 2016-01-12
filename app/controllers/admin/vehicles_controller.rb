# -*- encoding : utf-8 -*-
class Admin::VehiclesController < Admin::BaseController

  def index
    @page_title = 'Vehículos'
    if params[:owner_id].present?
      @vehicles = Vehicle.where(user_id: params[:owner_id]).order('created_at DESC').page params[:page]
    else
      @vehicles = Vehicle.order('created_at DESC').page params[:page]
    end
  end

  def new
    @page_title = 'Nuevo Vehículo'
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = BikeVehicle.new(vehicle_params)

    if @vehicle.save
      flash[:success] = 'Vehículo guardado con éxito!'
      redirect_to admin_vehicle_path(@vehicle)
    end
  end

  def show
    @vehicle = Vehicle.find(params[:id])
    @page_title = @vehicle.full_name
  end

  def destroy
    @vehicle = Vehicle.find(params[:id])
    @vehicle.destroy

    flash[:info] = 'El vehículo fue eliminado.'
    redirect_to vehicles_path
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
  end

  def update
    @vehicle = BikeVehicle.find(params[:id])
    if @vehicle.update!(vehicle_params)
      flash[:success] = 'Se modificó correctamente la motocicleta'
      redirect_to admin_vehicle_path(@vehicle)
    end
  end

  private

  def vehicle_params
    params.require(:bike_vehicle).permit(:bike_brand_id, :model, :year, :license_plate, :chassis_number, :kilometraje)
  end

end
# -*- encoding : utf-8 -*-
class Admin::VehiclesController < Admin::BaseController

  def index
    @page_title = 'Vehículos'
    @vehicles = Vehicle.order('created_at DESC').page params[:page]
  end

  def new
    if params[:client]
      @client = Client.find params[:client]
    end
    @page_title = 'Nuevo Vehículo'
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = BikeVehicle.new(params[:vehicle])

    unless params[:client].blank?
      @vehicle.client = Client.find params[:client]
    end

    if @vehicle.save
      flash[:success] = 'Vehículo guardado con éxito!'
      redirect_to vehicle_path(@vehicle)
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
    if @vehicle.is_a?(BikeVehicle)
      redirect_to edit_bike_vehicle_path(@vehicle)
    else
      redirect_to edit_car_vehicle_path(@vehicle)
    end
  end

end
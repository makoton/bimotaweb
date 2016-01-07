# -*- encoding : utf-8 -*-
class Me::VehiclesController < ApplicationController

  def index
    @vehicles = current_user.bike_vehicles.includes(:bike_brand)
  end

  def history

  end

  def edit
    @vehicle = current_user.bike_vehicles.find(params[:id])
  end

  def update

  end

  def new
    @page_title = 'Nueva Moto'
    @vehicle = current_user.bike_vehicles.new
  end

  def create
    @vehicle = current_user.bike_vehicles.new(bike_params)
    if @vehicle.save
      flash[:success] = 'Tu moto fue agregada con éxito'
      redirect_to me_vehicles_path
    else
      render :new
    end
  end

  private

  def bike_params
    params.require(:bike_vehicle).permit(:bike_brand_id, :model, :year, :license_plate, :chassis_number, :kilometraje)
  end

end
# -*- encoding : utf-8 -*-
class Me::VehiclesController < ApplicationController

  def index
    @vehicles = current_user.bike_vehicles.includes(:bike_brand)
  end

  def edit
    @vehicle = current_user.bike_vehicles.find(params[:id])
    @page_title = "Editando #{@vehicle.full_name}"
  end

  def update
    @vehicle = current_user.bike_vehicles.find(params[:id])

    if @vehicle.update!(bike_params)
      flash[:success] = 'Se modificó correctamente el vehículo.'
      redirect_to me_vehicles_path
    else
      flash[:error] = 'Ocurrio un error actualizando el registro, por favor intentalo de nuevo.'
      render :edit
    end
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

  def destroy
    @vehicle = current_user.bike_vehicles.find(params[:id])

    if @vehicle.destroy
      flash[:success] = 'La moto fue eliminada.'
    else
      flash[:error] = 'No pudimos eliminar la moto seleccionada, inténtalo nuevamente.'
    end

    redirect_to me_vehicles_path
  end

  private

  def bike_params
    params.require(:bike_vehicle).permit(:bike_brand_id, :model, :year, :license_plate, :chassis_number, :kilometraje)
  end

end
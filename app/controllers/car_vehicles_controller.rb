# -*- encoding : utf-8 -*-
class CarVehiclesController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @vehicle = CarVehicle.find(params[:id])
    @page_title = "Editando #{@vehicle.full_name}"
  end

  def update
    @vehicle = CarVehicle.find(params[:id])
    if @vehicle.update_attributes(params[:car_vehicle])
      flash[:success] = 'Se modificó correctamente el automóvil'
      redirect_to vehicles_path
    end
  end
end
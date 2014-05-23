# -*- encoding : utf-8 -*-
class BikeVehiclesController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @vehicle = BikeVehicle.find(params[:id])
    @page_title = "Editando #{@vehicle.full_name}"
  end

  def update
    @vehicle = BikeVehicle.find(params[:id])
    if @vehicle.update_attributes(params[:bike_vehicle])
      flash[:success] = 'Se modificó correctamente la motocicleta'
      redirect_to vehicles_path
    end
  end
end
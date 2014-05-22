# -*- encoding : utf-8 -*-
class VehiclesController < ApplicationController
  before_filter :authenticate_user!

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
    if params[:type] == 'auto'
      @vehicle = CarVehicle.new(params[:vehicle])
    else
      @vehicle = BikeVehicle.new(params[:vehicle])
    end

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
    @page_title = "Editando #{@vehicle.full_name}"
  end

  def update

  end
end
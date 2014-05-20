# -*- encoding : utf-8 -*-
class VehiclesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @page_title = 'Vehículos'
    @vehicles = Vehicle.page params[:page]
  end

  def new
    @page_title = 'Nuevo Vehículo'
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(params[:vehicle])

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
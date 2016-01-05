# -*- encoding : utf-8 -*-
class Me::VehiclesController < ApplicationController

  def index
    @vehicles = current_user.bike_vehicles
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

  end

end
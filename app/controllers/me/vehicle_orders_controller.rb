# -*- encoding : utf-8 -*-
class Me::VehicleOrdersController < ApplicationController
  before_filter :load_vehicle
  before_filter :load_order, only: :show

  def index
    @orders = @vehicle.orders.page params[:page]
  end

  def show

  end

  private

  def load_vehicle
    @vehicle = current_user.bike_vehicles.find(params[:vehicle_id])
  end

  def load_order
    @order = @vehicle.orders.find(params[:id])
  end

end
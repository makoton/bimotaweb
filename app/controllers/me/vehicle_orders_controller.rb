# -*- encoding : utf-8 -*-
class Me::VehicleOrdersController < ApplicationController
  before_filter :load_vehicle
  before_filter :load_order, only: :show

  def index
    @page_title = "Ordenes para tu #{@vehicle.full_name}"
    @orders = @vehicle.orders.page params[:page]
  end

  def show
    @page_title = "Orden ##{@order.uuid}"

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'orden_willy',
               :template => 'me/vehicle_orders/show.pdf.erb'
      end
    end
  end

  private

  def load_vehicle
    @vehicle = current_user.bike_vehicles.find(params[:vehicle_id])
  end

  def load_order
    @order = @vehicle.orders.find(params[:id])
  end

end
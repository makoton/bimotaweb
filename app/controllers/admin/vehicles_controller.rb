# -*- encoding : utf-8 -*-
class Admin::VehiclesController < Admin::BaseController

  before_filter :load_vehicle, except: [:index, :new, :create]

  def index
    @page_title = 'Vehículos'
    if params[:owner_id].present?
      @vehicles = BikeVehicle.where(user_id: params[:owner_id]).order('created_at DESC').page params[:page]
    elsif params[:query]
        # This complex query should get the results by name no mather what spanish character was entered.
      conditions = ["( REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(vehicles.model),'á', 'a'),'é', 'e'),'í', 'i'),'ó', 'o'),'ú', 'u'),'ñ', 'n')  LIKE ? OR LOWER(vehicles.license_plate) LIKE ? OR LOWER(vehicles.chassis_number) LIKE ? OR LOWER(bike_brands.name) LIKE ? )", "%#{params[:query].downcase}%", "%#{params[:query].downcase}%", "%#{params[:query].downcase}%", "%#{params[:query].downcase}%"]

        @vehicles = BikeVehicle.joins(:bike_brand).where(conditions).page params[:page]
    else
      @vehicles = BikeVehicle.order('created_at DESC').page params[:page]
    end
  end

  def new
    @page_title = 'Nuevo Vehículo'
    @vehicle = BikeVehicle.new
  end

  def create
    if @vehicle.save
      flash[:success] = 'Vehículo guardado con éxito!'
      redirect_to admin_vehicle_path(@vehicle)
    end
  end

  def show
    @page_title = @vehicle.full_name
  end

  def destroy
    @vehicle.destroy

    flash[:info] = 'El vehículo fue eliminado.'
    redirect_to vehicles_path
  end

  def edit

  end

  def update
    if @vehicle.update!(vehicle_params)
      flash[:success] = 'Se modificó correctamente la motocicleta'
      redirect_to admin_vehicle_path(@vehicle)
    end
  end

  private

  def vehicle_params
    params.require(:bike_vehicle).permit(:bike_brand_id, :model, :year, :license_plate, :chassis_number, :kilometraje)
  end

  def load_vehicle
    @vehicle = BikeVehicle.find(params[:id])
  end

end
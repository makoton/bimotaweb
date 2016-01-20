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
    @vehicle = BikeVehicle.new(vehicle_params)
    if @vehicle.save
      flash[:success] = 'Vehículo guardado con éxito!'
      redirect_to assign_to_user_admin_vehicle_path(@vehicle)
    end
  end

  def assign_to_user
    @page_title = 'Asigna el vehículo a un usuario.'
    @new_user = User.new
  end

  def find_users
    conditions = ["REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(users.name),'á', 'a'),'é', 'e'),'í', 'i'),'ó', 'o'),'ú', 'u'),'ñ', 'n')  LIKE ? OR LOWER(users.email) LIKE ?", "%#{params[:query].downcase}%", "%#{params[:query].downcase}%"]
    @users = User.where(conditions)
  end

  def fetch_selected_user
    @user = User.includes(:user_information).find(params[:user_id])
  end

  def assign
    if @vehicle.update!(vehicle_params)
      flash[:success] = 'El vehículo fue asignado con éxito.'
      redirect_to admin_vehicles_path and return
    else
      flash[:error] = 'Ocurrió un problema guardando los datos. Por favor inténtalo de nuevo.'
      redirect_to assign_to_user_admin_vehicle_path(@vehicle)
    end
  end

  def dissociate_user
    @vehicle.dissociate
    flash[:success] = 'El usuario y el vehículo fueron desvinculados.'
    redirect_to admin_vehicles_path
  end

  def create_and_assign_user
    params[:user][:password] = 'cambiame'
    params[:user][:password_confirmation] = 'cambiame'
    @user = User.new(user_params)

    if @user.save
      @user.reload
      @vehicle.user = @user
      @vehicle.save

      flash[:success] = 'El usuario fue creado y asignado al vehículo.'
      redirect_to admin_vehicles_path and return
    else
      flash[:error] = 'Ocurrió un error al guardar el usuario'
      redirect_to assign_to_user_admin_vehicle_path(@vehicle)
    end
  end

  def show
    @page_title = @vehicle.full_name
    @vehicle = BikeVehicle.find(params[:id])
    @orders = Order.where(vehicle_id: @vehicle.id)
    @user = @vehicle.user
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
    params.require(:bike_vehicle).permit(:bike_brand_id, :model, :year, :license_plate, :chassis_number, :kilometraje, :user_id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def load_vehicle
    @vehicle = BikeVehicle.find(params[:id])
  end

end
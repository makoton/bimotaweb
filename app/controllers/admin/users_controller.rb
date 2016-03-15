# -*- encoding : utf-8 -*-
class Admin::UsersController < Admin::BaseController

  def index
    @page_title = 'Usuarios'


    if params[:query]
      # This complex query should get the results by name no mather what spanish character was entered.
      conditions = ["REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(users.name),'á', 'a'),'é', 'e'),'í', 'i'),'ó', 'o'),'ú', 'u'),'ñ', 'n')  LIKE ? OR LOWER(users.email) LIKE ?", "%#{params[:query].downcase}%", "%#{params[:query].downcase}%"]

      @users = User.where(conditions).page params[:page]
    elsif params[:status] && params[:status] == 'admin'
      @users = User.where(role: 'admin').page params[:page]
    elsif params[:status] && params[:status] == 'mechanic'
      @users = User.where(role: 'mechanic').page params[:page]
    elsif params[:status] && params[:status] == 'operator'
      @users = User.where(role: 'operator').page params[:page]
    elsif params[:status] && params[:status] == 'client'
      @users = User.where(role: nil).page params[:page]
    else
      @users = User.page params[:page]
    end
  end

  def show

    @user = User.includes(:user_information).find(params[:id])
    @user_information = @user.user_information ? @user.user_information : @user.build_user_information
    @vehicles = @user.bike_vehicles
    unless @user
      flash[:info] = 'Ocurrió un error accediendo a la información de ese usuario. Inténtalo de nuevo.'
      redirect_to admin_users_path
    end

    @page_title = @user.name

  end

  def commit_user_information
    @user = User.find params[:id]
    @user_information = @user.build_user_information(user_information_params)
    @user_information.name = @user.name
    if @user_information.save
      flash[:success] = 'Se guardaron los datos con éxito!'
      redirect_to admin_user_path(@user) and return
    else
      flash[:error] = 'w/e'
      redirect_to admin_user_path(@user)
    end
  end

  def check_existing_rut
    render json: {result: UserInformation.rut_exists?(params[:rut])}.to_json
  end

  def new
    @page_title = 'Nuevo usuario.'
    @user = User.new
    @user.build_user_information
  end

  def create
    params[:user][:password] = 'cambiame'
    params[:user][:password_confirmation] = 'cambiame'
    @user = User.new(user_params)
    @user.user_information.name = @user.name
    if @user.save
      flash[:success] = 'El usuario fue creado exitosamente'
    else
      flash[:error] = 'Ocurrió un problema al crear el usuario, inténtalo nuevamente.'
    end
    redirect_to admin_users_path
  end

  private

  def user_information_params
    params.require(:user_information).permit(:name, :rut, :contact_phone, :address, :user_id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :user_information_attributes => [:id, :name, :rut, :contact_phone, :address, :user_id])
  end

end
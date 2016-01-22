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
    @vehicles = @user.bike_vehicles
    unless @user
      flash[:info] = 'Ocurrió un error accediendo a la información de ese usuario. Inténtalo de nuevo.'
      redirect_to admin_users_path
    end

    @page_title = @user.name

  end

  def invite
    unless can? :manage, User
      flash[:error] = 'No Autorizado >:('
      redirect_to root_path
    end
  end

  def commit_invite
    if params[:email].blank?
      flash[:info] = 'Ingresa un correo.'
      redirect_to :invite
    else
      User.invite!(:email => params[:email], :name => params[:name])
      flash[:success] = "Invitacion enviada a #{params[:name]}"
      redirect_to users_path
    end
  end

end
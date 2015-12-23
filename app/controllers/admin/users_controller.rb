# -*- encoding : utf-8 -*-
class Admin::UsersController < Admin::BaseController

  def index
    @page_title = 'Usuarios'
    @users = User.page params[:page]
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
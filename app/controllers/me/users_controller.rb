# -*- encoding : utf-8 -*-
class Me::UsersController < ApplicationController

  def show #me page
    @page_id = 'me'
    if current_user.user_information.blank?
      @user_information = current_user.build_user_information
    end
  end

  def commit_user_information
    @user_information = current_user.build_user_information(user_information_params)
    @user_information.name = current_user.name
    if @user_information.save
      flash[:success] = 'Se guardaron tus datos con éxito!'
      redirect_to me_root_path
    end
  end

  def profile
    @user_information = current_user.user_information || current_user.build_user_information
  end

  private

  def user_information_params
    params.require(:user_information).permit(:name,:rut,:contact_phone,:address, :user_id)
  end

end
# -*- encoding : utf-8 -*-
class SettingsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @page_title = 'Configuración'
    @settings = Setting.first
  end

  def update
    @settings = Setting.first

    if @settings.update_attributes(params[:setting])
      flash[:sucess] = 'Se guardaron correctamente las configuraciones'
      redirect_to settings_path
    else
      flash[:error] = 'Ocurrio un error guardando las configuraciones, intentalo de nuevo.'
      render :index
    end
  end
end
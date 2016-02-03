# -*- encoding : utf-8 -*-
class Admin::SettingsController < Admin::BaseController

  def show
    @page_title = 'Configuración'
    @settings = Setting.first
  end

  def commit_changes
    @settings = Setting.first

    if @settings.update!(settings_params)
      flash[:success] = 'Se guardaron correctamente las configuraciones'
      redirect_to admin_setting_path
    else
      flash[:error] = 'Ocurrio un error guardando las configuraciones, intentalo de nuevo.'
      render :show
    end
  end

  private

  def settings_params
    params.require(:setting).permit(:stock_mail_list)
  end
end
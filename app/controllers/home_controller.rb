class HomeController < ApplicationController
  skip_before_filter :authenticate_user!


  before_filter :redirect_to_home

  def index

  end

  def redirect_to_home
    if current_user
      redirect_to me_root_path and return
    end
  end

end
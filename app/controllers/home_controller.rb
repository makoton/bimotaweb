class HomeController < ApplicationController
  skip_before_filter :authenticate_user!

  layout 'home'

  def index

  end

end
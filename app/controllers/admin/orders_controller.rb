# -*- encoding : utf-8 -*-
class Admin::OrdersController < Admin::BaseController

  def index
    @page_title = 'Ordenes'
    @orders = Order.page params[:page]
  end
end
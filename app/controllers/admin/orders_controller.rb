# -*- encoding : utf-8 -*-
class Admin::OrdersController < Admin::BaseController

  before_filter :load_order, except: :index

  def index
    @page_title = 'Ordenes'
    @orders = Order.page params[:page]
  end

  def show

  end

  private

  def load_order
    @order = Order.find(params[:id])
  end
end
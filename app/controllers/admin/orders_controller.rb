# -*- encoding : utf-8 -*-
class Admin::OrdersController < Admin::BaseController

  before_filter :load_order, except: [:index, :new, :create]

  def index
    @page_title = 'Ordenes'

    if params[:status]
      show_orders = [Order::STATUS_INPROGRESS]
      if params[:status] == 'all'
        show_orders = [Order::STATUS_INPROGRESS, Order::STATUS_NEW, Order::STATUS_FINISHED]
      end
      if params[:status] == 'new'
        show_orders = [Order::STATUS_NEW]
      end
      if params[:status] == 'inprogress'
        show_orders = [Order::STATUS_INPROGRESS]
      end
      if params[:status] == 'delivered'
        show_orders = [Order::STATUS_FINISHED]
      end
      if params[:status] == 'canceled'
        show_orders = [Order::STATUS_CANCELED]
      end

      @orders = Order.where(current_state: show_orders).page params[:page]
    elsif params[:query]

      # This complex query should get the results by name no mather what spanish character was entered.
      conditions = ["( REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(users.name),'á', 'a'),'é', 'e'),'í', 'i'),'ó', 'o'),'ú', 'u'),'ñ', 'n')  LIKE ? OR LOWER(users.email) LIKE ? OR LOWER(orders.uuid) LIKE ?) AND current_state IN('new','inprogress','finished')", "%#{params[:query].downcase}%", "%#{params[:query].downcase}%", "%#{params[:query].downcase}%"]

      @orders = Order.joins(:user).where(conditions).page params[:page]
    else
      @orders = Order.page params[:page]
    end

    @total_new_orders = Order.count_by_status(Order::STATUS_NEW)
    @total_inprogress_orders = Order.count_by_status(Order::STATUS_INPROGRESS)
    @total_finished_orders = Order.count_by_status(Order::STATUS_FINISHED)
  end

  def show

  end

  def new
    @page_title = 'Nueva Orden'
  end

  private

  def load_order
    @order = Order.find(params[:id])
  end
end
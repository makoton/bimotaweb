class Api::V1::OrdersController < Api::V1::BaseController

  def index
    conditions = {}
    conditions.merge!(user_id: params[:user_id]) if params[:user_id].present?
    conditions.merge!(vehicle_id: params[:vehicle_id]) if params[:vehicle_id].present?
    @orders = Order.where(conditions)

    render json:            @orders,
           each_serializer: OrderListSerializer#, meta: pagination_meta(@memberships)
  end

end
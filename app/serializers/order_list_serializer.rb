class OrderListSerializer < ActiveModel::Serializer

  attributes :id, :user_id, :user_name, :created_at, :updated_at, :vehicle_full_name, :uuid, :current_state

  def user_name
    object.user.name
  end

  def vehicle_full_name
    object.vehicle.full_name
  end

end

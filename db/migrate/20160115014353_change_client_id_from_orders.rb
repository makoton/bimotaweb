class ChangeClientIdFromOrders < ActiveRecord::Migration
  def change
    rename_column :orders, :client_id, :user_id
  end
end

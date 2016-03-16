class AddLastUpdateToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :last_update, :datetime
  end
end

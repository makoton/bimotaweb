class RemoveCommentsFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :comments
  end
end

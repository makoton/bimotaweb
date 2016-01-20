class AddCommentsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :comments, :text
  end
end

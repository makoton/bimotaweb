class AddFieldsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :created_by, :string
    add_column :orders, :started_by, :string
    add_column :orders, :started_at, :datetime
    add_column :orders, :finished_by, :string
    #add_column :orders, :finished_at, :datetime
  end
end

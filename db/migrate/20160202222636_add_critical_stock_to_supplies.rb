class AddCriticalStockToSupplies < ActiveRecord::Migration
  def change
    add_column :supplies, :critical_stock, :integer, default: 5
  end
end

class AddPriceToSupplyItems < ActiveRecord::Migration
  def change
    add_column :supply_items, :price_at_assignment, :float
  end
end

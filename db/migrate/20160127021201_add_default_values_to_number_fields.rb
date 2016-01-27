class AddDefaultValuesToNumberFields < ActiveRecord::Migration
  def change
    #column changes
    change_column :tasks, :labor_cost, :float, :default => 0.0
    change_column :tasks, :price, :float, :default => 0.0
    change_column :tasks, :total_amount, :float, :default => 0.0
    change_column :supply_items, :price_at_assignment, :float, :default => 0.0
    change_column :supplies, :price, :float, :default => 0.0

    #reprocess existing data
    Task.all.each do |task|
      task.labor_cost = 0.0 if task.labor_cost.blank?
      task.price = 0.0 if task.price.blank?
      task.total_amount = 0.0 if task.total_amount.blank?
      task.save
    end

    SupplyItem.all.each do |item|
      item.price_at_assignment = 0.0 if item.price_at_assignment.blank?
      item.save
    end

    Supply.all.each do |supply|
      supply.price = 0.0 if supply.price.blank?
      supply.save
    end
  end
end

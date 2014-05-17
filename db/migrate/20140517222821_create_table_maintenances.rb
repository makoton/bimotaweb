class CreateTableMaintenances < ActiveRecord::Migration
  def up
    create_table :maintenances do |t|
      t.string :kilometraje
      t.integer :base_price
      t.integer :labor_cost
    end
  end

  def down
    drop_table :maintenances
  end
end

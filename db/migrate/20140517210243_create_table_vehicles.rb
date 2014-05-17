class CreateTableVehicles < ActiveRecord::Migration
  def up
    create_table :vehicles do |t|
      t.string :brand
      t.string :model
      t.integer :year
      t.string :license_plate
      t.string :chassis_number
      t.integer :kilometraje
      t.string :type
      t.integer :client_id

      t.timestamps
    end

    add_index :vehicles, :client_id
    add_index :vehicles, :brand
    add_index :vehicles, :model
    add_index :vehicles, :license_plate
  end

  def down
    remove_index :vehicles, :client_id
    remove_index :vehicles, :brand
    remove_index :vehicles, :model
    remove_index :vehicles, :license_plate
    drop_table :vehicles
  end
end

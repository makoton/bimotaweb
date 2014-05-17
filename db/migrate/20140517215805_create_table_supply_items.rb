class CreateTableSupplyItems < ActiveRecord::Migration
  def up
    create_table :supply_items do |t|
      t.integer :supply_id
      t.string :status
      t.integer :service_id

      t.timestamps
    end
  end

  def down
    drop_table :supply_items
  end
end

class CreateTableOrders < ActiveRecord::Migration
  def up
    create_table :orders do |t|
      t.string :current_state
      t.date :finished_at
      t.integer :client_id
      t.integer :vehicle_id
      t.string :uuid
    end

    add_index :orders, :uuid, unique: true
  end

  def down
    remove_index :orders, :uuid
    drop_table :orders
  end
end

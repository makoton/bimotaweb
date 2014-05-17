class CreateTableServices < ActiveRecord::Migration
  def up
    create_table :services do |t|
      t.integer :order_id
      t.integer :user_id
      t.string :title
      t.string :description
      t.integer :labor_cost
      t.integer :total_cost

      t.timestamps
    end
  end

  def down
    drop_table :services
  end
end

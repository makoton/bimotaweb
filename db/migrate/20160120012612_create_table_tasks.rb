class CreateTableTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :created_by
      t.float :labor_cost
      t.float :price
      t.float :total_amount
      t.integer :order_id
      t.string :title
      t.text :observations

      t.timestamps
    end
  end
end

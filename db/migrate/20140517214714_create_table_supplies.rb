class CreateTableSupplies < ActiveRecord::Migration
  def up
    create_table :supplies do |t|
      t.string :brand
      t.string :model
      t.integer :price
      t.string :type
      t.string :category

      t.timestamps
    end

    add_index :supplies, :model
    add_index :supplies, :category
  end

  def down
    remove_index :supplies ,:model
    remove_index :supplies ,:category
    drop_table :supplies
  end
end

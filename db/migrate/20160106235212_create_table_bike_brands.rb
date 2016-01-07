class CreateTableBikeBrands < ActiveRecord::Migration
  def change
    create_table :bike_brands do |t|
      t.string :name

      t.timestamps
    end

    add_index :bike_brands, :name

    remove_column :vehicles, :brand
    add_column :vehicles, :bike_brand_id, :integer
  end
end

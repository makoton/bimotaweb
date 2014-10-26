class ChangeStuff < ActiveRecord::Migration
  def up
    remove_column :settings, :consumable_categories
    remove_column :settings, :part_categories

    create_table :supply_categories do |t|
      t.string :name
      t.string :supply_type
      t.timestamps
    end
  end

  def down
    drop_table :supply_categories
  end
end

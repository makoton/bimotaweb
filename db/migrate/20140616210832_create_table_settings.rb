class CreateTableSettings < ActiveRecord::Migration
  def up
    create_table :settings do |t|
      t.text :consumable_categories
      t.text :part_categories

      t.timestamps
    end
  end

  def down
    drop_table :settings
  end
end

class CreateTableClients < ActiveRecord::Migration
  def up
    create_table :clients do |t|
      t.string :names
      t.string :last_names
      t.string :rut
      t.string :contact_phone
      t.string :address
      t.string :comments
      t.string :email

      t.timestamps
    end

    add_index :clients, :rut, unique: true
  end

  def down
    remove_index :clients, :rut
    drop_table :clients
  end
end

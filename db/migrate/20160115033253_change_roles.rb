class ChangeRoles < ActiveRecord::Migration
  def change
    drop_table :roles
    drop_table :roles_users

    add_column :users, :role, :string
  end
end

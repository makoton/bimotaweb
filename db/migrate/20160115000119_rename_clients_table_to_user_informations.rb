class RenameClientsTableToUserInformations < ActiveRecord::Migration
  def change
    rename_table :clients, :user_informations
  end
end

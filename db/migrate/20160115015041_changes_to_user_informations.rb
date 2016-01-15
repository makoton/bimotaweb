class ChangesToUserInformations < ActiveRecord::Migration
  def change
    remove_column :user_informations, :last_names
    rename_column :user_informations, :names, :name
  end
end

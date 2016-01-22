class RemoveEmailFromUserInformation < ActiveRecord::Migration
  def change
    remove_column :user_informations, :email
  end
end

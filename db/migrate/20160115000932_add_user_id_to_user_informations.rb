class AddUserIdToUserInformations < ActiveRecord::Migration
  def change
    add_column :user_informations, :user_id, :integer
  end
end

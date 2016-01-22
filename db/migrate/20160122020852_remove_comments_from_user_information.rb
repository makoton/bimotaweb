class RemoveCommentsFromUserInformation < ActiveRecord::Migration
  def change
    remove_column :user_informations, :comments
  end
end

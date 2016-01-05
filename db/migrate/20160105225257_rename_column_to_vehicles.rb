class RenameColumnToVehicles < ActiveRecord::Migration
  def change
    rename_column :vehicles, :client_id, :user_id
  end
end

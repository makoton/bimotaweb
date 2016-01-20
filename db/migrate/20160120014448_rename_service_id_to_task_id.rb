class RenameServiceIdToTaskId < ActiveRecord::Migration
  def change
    rename_column :supply_items, :service_id, :task_id
  end
end

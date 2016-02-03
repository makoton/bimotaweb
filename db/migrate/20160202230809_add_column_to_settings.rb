class AddColumnToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :stock_mail_list, :text

    Setting.create
  end
end

class ProcessLastChange < ActiveRecord::Migration
  def change
    Order.all.each do |order|
      order.update_last_change
    end
  end
end

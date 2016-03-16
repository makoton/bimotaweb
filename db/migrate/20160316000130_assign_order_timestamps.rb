class AssignOrderTimestamps < ActiveRecord::Migration
  def change
    Order.all.each do |order|
      date = Time.now
      order.update_attributes({created_at: date, updated_at: date})
    end
  end
end

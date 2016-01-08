# -*- encoding : utf-8 -*-
class Supply < ActiveRecord::Base

  #accessors
  # attr_accessible :brand, :model, :price, :category

  #relations
  has_many :supply_items


  #business methods

  def title
    "#{brand} #{model}"
  end

  #add units to stock
  def add_units(qty)
    qty.to_i.times do
      #create item
      item = supply_items.new
      item.status = SupplyItem::STATUS_AVAILABLE
      item.save
    end
  end
end
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
    qty.times do
      #create item
      supply_items.create
    end
  end
end
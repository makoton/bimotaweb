# -*- encoding : utf-8 -*-
class Vehicle < ActiveRecord::Base

  #relations
  belongs_to :user
  belongs_to :bike_brand

  #accessors
  # attr_accessible :brand, :model, :year, :license_plate, :chassis_number, :kilometraje

  #business methods

  def full_name
    "#{bike_brand.name} #{model}"
  end
end
# -*- encoding : utf-8 -*-
class Vehicle < ActiveRecord::Base

  #relations
  belongs_to :client

  #accessors
  attr_accessible :brand, :model, :year, :license_plate, :chassis_number, :kilometraje

  #business methods

  def full_name
    "#{brand} #{model}"
  end
end
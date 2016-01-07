# -*- encoding : utf-8 -*-
class BikeBrand < ActiveRecord::Base

  has_many :bike_vehicles

  validates_uniqueness_of :name, case_sensitive: false, message: 'La marca que ingresaste ya existe.'
end
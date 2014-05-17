# -*- encoding : utf-8 -*-
class Client < ActiveRecord::Base

  #scopes

  #relations
  has_many :vehicles
  has_many :orders
  has_many :bikes, class_name: 'BikeVehicle'
  has_many :cars, class_name: 'CarVehicle'

  #callbacks
  before_create :strip_rut

  #business methods

  def full_name
    "#{names} #{last_names}"
  end

  def strip_rut
    self.rut = rut.gsub('.', '').gsub('-','')
  end

  def format_rut

  end
end
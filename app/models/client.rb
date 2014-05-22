# -*- encoding : utf-8 -*-
class Client < ActiveRecord::Base

  #accessors
  attr_accessible :names, :last_names, :rut, :address, :contact_phone, :comments, :email
  #scopes

  #relations
  has_many :vehicles
  has_many :orders
  has_many :bikes, class_name: 'BikeVehicle'
  has_many :cars, class_name: 'CarVehicle'

  #callbacks
  before_create :strip_rut

  #validations
  validates_presence_of :names, :last_names, :rut

  #business methods

  def full_name
    "#{names} #{last_names}"
  end

  def short_name
    "#{names.split(' ').first} #{last_names.split(' ').first}"
  end

  def strip_rut
    self.rut = rut.gsub('.', '').gsub('-','').gsub(' ','')
  end

  def format_rut

  end
end
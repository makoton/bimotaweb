# -*- encoding : utf-8 -*-
class UserInformation < ActiveRecord::Base

  #relations
  belongs_to :user

  #callbacks
  before_create :strip_rut

  #validations
  validates_presence_of :name, :rut, :address, :contact_phone

  #business methods



  def strip_rut
    self.rut = rut.gsub('.', '').gsub('-','').gsub(' ','')
  end

  def format_rut

  end
end
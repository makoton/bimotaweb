# -*- encoding : utf-8 -*-
class UserInformation < ActiveRecord::Base

  #relations
  belongs_to :user

  #callbacks
  before_create :strip_rut_callback

  #validations
  validates_presence_of :name, :rut, :address, :contact_phone
  validates_uniqueness_of :rut

  #business methods

  def self.rut_exists?(rut)
    self.where('rut like ?', "%#{strip_rut(rut)}").any?
  rescue
    false
  end

  def self.strip_rut(rut)
    rut = rut.gsub('.', '').gsub('-','').gsub(' ','')
  end

  def strip_rut_callback
    self.rut = UserInformation.strip_rut(self.rut)
  end

end
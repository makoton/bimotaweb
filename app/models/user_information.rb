# -*- encoding : utf-8 -*-
class UserInformation < ActiveRecord::Base

  #relations
  belongs_to :user

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
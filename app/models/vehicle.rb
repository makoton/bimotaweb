# -*- encoding : utf-8 -*-
class Vehicle < ActiveRecord::Base

  #relations
  belongs_to :owner, class_name: Client

  #business methods

  def full_name
    "#{brand} #{model}"
  end
end
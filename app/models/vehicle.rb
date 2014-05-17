# -*- encoding : utf-8 -*-
class Vehicle < ActiveRecord::Base

  #relations
  belongs_to :client
end
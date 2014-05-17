# -*- encoding : utf-8 -*-
class Supply < ActiveRecord::Base

  #relations
  has_many :supply_items
end
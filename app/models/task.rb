# -*- encoding : utf-8 -*-
class Task < ActiveRecord::Base

  #relations
  belongs_to :order
  has_many :supply_items

end
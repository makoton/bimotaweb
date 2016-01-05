# -*- encoding : utf-8 -*-
class Order < ActiveRecord::Base

  #relations
  belongs_to :user
end
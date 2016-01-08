# -*- encoding : utf-8 -*-
class SupplyItem < ActiveRecord::Base

  #relations
  belongs_to :supply
  belongs_to :service

  #scopes
  scope :available, -> {where(status: STATUS_AVAILABLE)}
  scope :unavailable, -> {where(status: STATUS_UNAVAILABLE)}

  scope :available_by_category, lambda {|cat| available.where(category: cat)}


  #constants
  STATUS_AVAILABLE = 'available'
  STATUS_UNAVAILABLE = 'unavailable'

  #representa 'uno' del repuesto/insumo en el stock, la suma de estos deberia ser el total de stock de la wea con status
end
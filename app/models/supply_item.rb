# -*- encoding : utf-8 -*-
class SupplyItem < ActiveRecord::Base

  #relations
  belongs_to :supply
  belongs_to :task

  #scopes
  scope :available, -> {where(status: STATUS_AVAILABLE)}
  scope :unavailable, -> {where(status: STATUS_UNAVAILABLE)}

  #constants
  STATUS_AVAILABLE = 'available'
  STATUS_UNAVAILABLE = 'unavailable'

  #representa 'uno' del repuesto/insumo en el stock, la suma de estos deberia ser el total de stock de la wea con status

  def use_on(task)
    self.task = task
    self.status = STATUS_UNAVAILABLE
    self.save
  end
end
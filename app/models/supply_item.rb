# -*- encoding : utf-8 -*-
class SupplyItem < ActiveRecord::Base

  #relations
  belongs_to :supply
  belongs_to :task

  #constants
  STATUS_AVAILABLE = 'available'
  STATUS_UNAVAILABLE = 'unavailable'

  #counter cache
  counter_culture :supply, touch: true, :column_name => Proc.new { |supply| supply.is_available? ? 'available_supplies_count' : nil },
                  :column_names => {
                      ['supply_items.status = ?', STATUS_AVAILABLE] => 'available_supplies_count',
                      ['supply_items.status = ?', STATUS_UNAVAILABLE] => 'unavailable_supplies_count'
                  }

  #scopes
  scope :available, -> { where(status: STATUS_AVAILABLE) }
  scope :unavailable, -> { where(status: STATUS_UNAVAILABLE) }

  #representa 'uno' del repuesto/insumo en el stock, la suma de estos deberia ser el total de stock de la wea con status

  def use_on(task)
    self.task = task
    self.status = STATUS_UNAVAILABLE
    self.price_at_assignment = self.supply.price
    self.save
    task.recalc!
  end

  def back_to_stock(task)
    self.task = nil
    self.status = STATUS_AVAILABLE
    self.price_at_assignment = 0
    self.save
    task.recalc!
  end

  def is_available?
    return true if self.status == STATUS_AVAILABLE
    false
  end
end
# -*- encoding : utf-8 -*-
class Task < ActiveRecord::Base

  #relations
  belongs_to :order
  has_many :supply_items

  STATUS_PENDING = 'pending'
  STATUS_FINISHED = 'finished'

  scope :pending, -> { where(status: STATUS_PENDING) }
  scope :finished, -> { where(status: STATUS_FINISHED) }

  def finish!
    self.update_attribute(:status, STATUS_FINISHED)
  end

  def pending!
    self.update_attribute(:status, STATUS_PENDING)
  end

  def supplies_by_type(type)
    supply_items.joins(:supply).where('supplies.type = ?', type)
  rescue
    []
  end

  def total_cost_of_supplies_by_type(type)
    total = 0
    supplies_by_type(type).each{|item| total += item.price_at_assignment.to_i}
    return total
  rescue
    0
  end

  def recalc!
    costs = (self.total_cost_of_supplies_by_type('ConsumableSupply')) + (self.total_cost_of_supplies_by_type('PartSupply')) + self.labor_cost
    self.update_attribute(:total_amount, costs)
    self.save
  end
end
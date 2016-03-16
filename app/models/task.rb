# -*- encoding : utf-8 -*-
class Task < ActiveRecord::Base

  #relations
  belongs_to :order
  has_many :supply_items
  has_many :comments

  STATUS_PENDING = 'pending'
  STATUS_FINISHED = 'finished'

  scope :pending, -> { where(status: STATUS_PENDING) }
  scope :finished, -> { where(status: STATUS_FINISHED) }

  after_save :update_order_change

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

  def consumed_supplies_by_type(type)
    type.constantize.where(id: [self.supplies_by_type(type).select('supply_items.supply_id').uniq.map{|s| s.supply_id}])
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

  def update_order_change
    self.order.save
  end
end
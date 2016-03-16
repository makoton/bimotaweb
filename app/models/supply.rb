# -*- encoding : utf-8 -*-
class Supply < ActiveRecord::Base

  #accessors
  # attr_accessible :brand, :model, :price, :category

  #relations
  has_many :supply_items


  #business methods

  def title
    "#{brand} - #{model}".titleize
  end

  #add units to stock
  def add_units(qty)
    qty.to_i.times do
      #create item
      item = supply_items.new
      item.status = SupplyItem::STATUS_AVAILABLE
      item.save
    end
  end

  def self.with_stock(type)
    ary_for_select = []
    Supply.includes(:supply_items).where(type: type).each do |supply|
      if supply.supply_items.available.any?
        ary_for_select << [supply.title, supply.id]
      end
    end
    ary_for_select
  end

  def assign_to_task(task, quantity)
    quantity.to_i.times do
      self.supply_items.available.last.use_on(task)
    end
  end

  def unassign_from_task(task, quantity)
    quantity.to_i.times do
      self.supply_items.where(task_id: task.id).last.back_to_stock(task)
    end
  end

  def notify_critical_stock
    if self.available_supplies_count <= critical_stock
      #TODO send email
      Setting.first.mail_list.each do |email|
        #send_email(email)
        SupplyMailer.low_stock(email, self).deliver_now
      end
    end
  end
end
# -*- encoding : utf-8 -*-
class SupplyCategory < ActiveRecord::Base

  TYPE_CONSUMABLE = 'consumable'
  TYPE_PART = 'part'

  scope :part_categories, -> { where(supply_type: TYPE_PART) }
  scope :consumable_categories, -> { where(supply_type: TYPE_CONSUMABLE) }

    # attr_accessible :name, :supply_type
end
# -*- encoding : utf-8 -*-
class SupplyCategory < ActiveRecord::Base

  TYPE_CONSUMABLE = 'consumable'
  TYPE_PART = 'part'

  scope :part_categories, -> { where(supply_type: TYPE_PART) }
  scope :consumable_categories, -> { where(supply_type: TYPE_CONSUMABLE) }

  validates_uniqueness_of :name, case_sensitive: false

    # attr_accessible :name, :supply_type

  #categorias para realizar filtros
end
# -*- encoding : utf-8 -*-
class Task < ActiveRecord::Base

  #relations
  belongs_to :order
  has_many :supply_items

  STATUS_PENDING = 'pending'
  STATUS_FINISHED = 'finished'

  scope :pending, -> { where(status: STATUS_PENDING) }
  scope :finished, -> { where(status: STATUS_FINISHED) }

end
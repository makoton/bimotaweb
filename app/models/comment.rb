# -*- encoding : utf-8 -*-
class Comment < ActiveRecord::Base

  belongs_to :order

  validates_presence_of :content
end
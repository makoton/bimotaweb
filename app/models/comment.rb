# -*- encoding : utf-8 -*-
class Comment < ActiveRecord::Base

  belongs_to :order
  belongs_to :user

  validates_presence_of :content
end
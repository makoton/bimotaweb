# -*- encoding : utf-8 -*-
class Comment < ActiveRecord::Base

  belongs_to :order
  belongs_to :user
  belongs_to :task

  validates_presence_of :content
end
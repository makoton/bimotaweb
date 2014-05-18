# -*- encoding : utf-8 -*-
class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def index

  end
end
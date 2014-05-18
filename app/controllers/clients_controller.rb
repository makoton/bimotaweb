# -*- encoding : utf-8 -*-
class ClientsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @page_title = 'Clientes'
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def create

  end
end
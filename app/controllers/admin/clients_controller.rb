# -*- encoding : utf-8 -*-
class Admin::ClientsController < Admin::BaseController

  def index
    @page_title = 'Clientes'
    @clients = Client.page params[:page]
  end

  def new
    @page_title = 'Nuevo Cliente'
    @client = Client.new
  end

  def create
    @client = Client.new(params[:client])
    if @client.save
      redirect_to client_path(@client)
    else
      render :new
    end
  end

  def edit
    @client = Client.find(params[:id])
    @page_title = "Editando a #{@client.full_name}"
  end

  def update
    @client = Client.find(params[:id])
    if @client.update_attributes(params[:client])
      flash[:success] = "Se modificó correctamente el cliente #{@client.short_name}"
      redirect_to clients_path
    else
      render :edit
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    flash[:info] = 'El cliente fue eliminado'
    redirect_to clients_path
  end

  def show
    @client = Client.find(params[:id])
    @page_title = @client.full_name
    @vehicles = @client.vehicles
  end
end
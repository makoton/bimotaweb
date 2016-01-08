# -*- encoding : utf-8 -*-
class Admin::ConsumableSuppliesController < Admin::BaseController

  def index
    @page_title = 'Insumos'
    @con_supplies = ConsumableSupply.page params[:page] #needs to have filters
  end

  def new
    @page_title = 'Nuevo Insumo'
    @consumable_supply = ConsumableSupply.new
    @categories = SupplyCategory.consumable_categories
  end

  def create
    @consumable_supply = ConsumableSupply.create(supply_params)

    if params[:new_category]
      new_category = SupplyCategory.create(name: params[:new_category], supply_type: SupplyCategory::TYPE_CONSUMABLE)
      @consumable_supply.category = new_category.name
    end

    if @consumable_supply.save
      flash[:success] = 'Insumo creado'
      if params[:units].to_i > 0
        @consumable_supply.add_units(params[:units].to_i)
      end
      redirect_to admin_consumable_supplies_path
    else
      flash[:error] = 'Ocurrio un error creando el insumo, por favor intentalo de nuevo.'
      render :new
    end
  end

  def edit
    @consumable_supply = ConsumableSupply.find params[:id]
    @page_title = @consumable_supply.title.titleize
  end

  def update
    @consumable_supply = ConsumableSupply.find params[:id]
    if @consumable_supply.update_attributes(params[:consumable_supply])
      flash[:success] = 'Se modificó correctamente el insumo'
      redirect_to admin_consumable_supplies_path
    else
      flash[:error] = 'Ocurrio un error actualizando el registro, por favor intentalo de nuevo.'
      render :edit
    end
  end

  def destroy
    @consumable_supply = ConsumableSupply.find params[:id]
    if @consumable_supply.destroy
      flash[:success] = 'Insumo Eliminado'
    else
      flash[:error] = 'Ocurrió un error eliminando el insumo.'
    end
    redirect_to admin_consumable_supplies_path
  end

  #Add units to stock
  def add_units_modal
    @supply = ConsumableSupply.find(params[:supply_id])
  end

  def add_units
    @consu = ConsumableSupply.find params[:id]
    if @consu.add_units(params[:units])
      flash[:success] = "Se agregaron #{params[:units]} unidades a #{@consu.title.titleize}"
    else
      flash[:error] = "No se pudieron agregar unidades a #{@consu.title.titleize}"
    end

    redirect_to admin_consumable_supplies_path
  end

  private

  def supply_params
    params.require(:consumable_supply).permit(:brand, :model, :price, :category)
  end
end
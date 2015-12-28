# -*- encoding : utf-8 -*-
class Admin::PartSuppliesController < Admin::BaseController

  def index
    @page_title = 'Repuestos'
    @part_supplies = PartSupply.page params[:page] #needs to have filters
  end

  def new
    @page_title = 'Nuevo Repuesto'
    @part = PartSupply.new
    @categories = SupplyCategory.part_categories
  end

  def create
    @part = PartSupply.create(params[:part_supply])

    if params[:new_category]
      new_category = SupplyCategory.create(name: params[:new_category], supply_type: SupplyCategory::TYPE_PART)
      @part.category = new_category.name
    end

    if @part.save
      flash[:success] = 'Repuesto creado'
      if params[:units].to_i > 0
        @part.add_units(params[:units].to_i)
      end
      redirect_to part_supplies_path
    else
      flash[:error] = 'Ocurrio un error creando el repuesto, por favor intentalo de nuevo.'
      render :new
    end
  end

  def edit
    @part = PartSupply.find params[:id]
    @page_title = @part.title.titleize
  end

  def update
    @part = PartSupply.find prams[:id]
    if @part.update_attributes(params[:part_supply])
      flash[:success] = 'Se modificó correctamente el repuesto'
      redirect_to part_supplies_path
    else
      flash[:error] = 'Ocurrio un error actualizando el registro, por favor intentalo de nuevo.'
      render :edit
    end
  end

  def destroy
    @part = PartSupply.find params[:id]
    if @part.destroy
      flash[:success] = 'Se eliminó el repuesto.'
    else
      flash[:error] = 'Ocurrió un error eliminando el repuesto.'
    end
    redirect_to part_supplies_path
  end

  #Add units to stock
  def add_units
    @part = PartSupply.find params[:id]
    if @part.add_units(params[:units])
      flash[:success] = "Se agregaron #{params[:units]} unidades a #{@part.title.titleize}"
    else
      flash[:error] = "No se pudieron agregar unidades a #{@part.title.titleize}"
    end

    redirect_to part_supplies_path
  end
end
# -*- encoding : utf-8 -*-
class Admin::BikeBrandsController < Admin::BaseController

  def index
    @bike_brands = BikeBrand.all
  end

  def new
    @bike_brand = BikeBrand.new
  end

  def create
    @bike_brand = BikeBrand.new(brand_params)

    if @bike_brand.save
      flash[:success] = 'Marca guardada con éxito'
      redirect_to admin_bike_brands_path
    else
      render :new
    end
  end

  def edit
    @bike_brand = BikeBrand.find(params[:id])
  end

  def update
    @bike_brand = BikeBrand.find(params[:id])

    if @bike_brand.update!(brand_params)
      flash[:success] = "La marca #{@bike_brand.name.titleize} ha sido actualizada"
      redirect_to admin_bike_brands_path
    else
      render :edit
    end
  end

  private

  def brand_params
    params.require(:bike_brand).permit(:name)
  end
end
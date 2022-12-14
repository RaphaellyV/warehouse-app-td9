class ProductModelsController < ApplicationController

  def index
    @product_models = ProductModel.all.order(:name)
  end

  def show
    @product_model = ProductModel.find(params[:id])
  end

  def new
    @product_model = ProductModel.new
    @suppliers = Supplier.all.order(:brand_name)
  end

  def create
    product_model_params = params.require(:product_model).permit(:name, :weight, :width, :height, 
                                          :depth, :sku, :supplier_id)
    @product_model = ProductModel.new(product_model_params)
    if @product_model.save
      redirect_to @product_model, notice: t(:product_model_creation_success)
    else
      @suppliers = Supplier.all.order(:brand_name)
      flash.now[:alert] = t(:product_model_creation_error)
      render 'new'
    end
  end
end
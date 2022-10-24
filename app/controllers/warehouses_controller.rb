class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :edit, :update, :destroy]

  def show
    @stock_products = @warehouse.stock_products.group(:product_model).count
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    
    if @warehouse.save
      redirect_to root_url, notice: t(:warehouse_creation_success)
    else
      flash.now[:alert] = t(:warehouse_creation_error)
      render 'new' 
    end    
  end

  def edit; end

  def update 
    if @warehouse.update(warehouse_params)
      redirect_to warehouse_url(@warehouse.id), notice: t(:warehouse_update_success)
    else
      flash.now[:alert] = t(:warehouse_update_error)
      render 'edit'
    end
  end

  def destroy
    @warehouse.destroy
    redirect_to root_url, notice: t(:warehouse_removal_success)
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :description, 
                                      :address, :postal_code, :area, :state)
  end
end
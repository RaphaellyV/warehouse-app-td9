class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :edit, :update]
  
  def index
    @suppliers = Supplier.all.order(:brand_name)
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)

    if @supplier.save
      redirect_to supplier_url(@supplier.id), notice: t(:supplier_creation_success)
    else
      flash.now[:alert] = t(:supplier_creation_error)
      render 'new'
    end
  end

  def show
    @product_models = @supplier.product_models.order(:name)
  end

  def edit; end

  def update
    if @supplier.update(supplier_params)
      redirect_to supplier_url(@supplier.id), notice: t(:supplier_update_success)
    else
      flash.now[:alert] = t(:supplier_update_error)
      render 'edit'
    end
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end
  
  def supplier_params
    params.require(:supplier).permit(:corporate_name, :brand_name, :registration_number, :full_address, 
                                      :city, :state, :email, :postal_code, :phone_number)
  end
end
class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)

    if @supplier.save
      redirect_to supplier_url(@supplier.id), notice: 'Fornecedor cadastrado com sucesso!'
    else
      flash.now[:notice] = "Fornecedor não cadastrado."
      render 'new'
    end
  end

  def show
    @supplier = Supplier.find(params[:id])
  end

  private
  
  def supplier_params
    params.require(:supplier).permit(:corporate_name, :brand_name, :registration_number, :full_address, 
                                      :city, :state, :email, :postal_code, :phone_number)
  end
end
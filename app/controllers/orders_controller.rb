class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def new
    @warehouses = Warehouse.all.order(:name)
    @suppliers = Supplier.all.order(:corporate_name)
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user

    if @order.save
      redirect_to @order, notice: 'Pedido cadastrado com sucesso!'
    else
      @warehouses = Warehouse.all.order(:name)
      @suppliers = Supplier.all.order(:corporate_name)
      flash.now[:alert] = "Não foi possível cadastrar o Pedido."
      render 'new'
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def edit
    @order = Order.find(params[:id])
    if @order.user == current_user
      @warehouses = Warehouse.all.order(:name)
      @suppliers = Supplier.all.order(:corporate_name)
    else
      redirect_to @order, alert: 'Não é possível editar este Pedido.'
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to @order, notice: 'Pedido atualizado com sucesso!'
    else
      flash.now[:alert] = 'Não foi possível atualizar o Pedido.'
      @warehouses = Warehouse.all.order(:name)
      @suppliers = Supplier.all.order(:corporate_name)
      render 'edit'
    end
  end

  def search
    @code = params[:query]
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  private

  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end
end
class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
    @warehouses = Warehouse.all.order(:name)
    @suppliers = Supplier.all.order(:corporate_name)
  end

  def create
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
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
end
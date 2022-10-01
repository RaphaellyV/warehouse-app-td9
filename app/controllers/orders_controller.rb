class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update]
  before_action :set_warehouses_and_suppliers, only: [:new, :edit]

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user

    if @order.save
      redirect_to @order, notice: t(:order_creation_success)
    else
      @warehouses = Warehouse.all.order(:name)
      @suppliers = Supplier.all.order(:corporate_name)
      flash.now[:alert] = t(:order_creation_error)
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: t(:order_update_success)
    else
      flash.now[:alert] = t(:order_update_error)
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

  def set_order
    @order = Order.find(params[:id])
  end

  def set_warehouses_and_suppliers
    @warehouses = Warehouse.all.order(:name)
    @suppliers = Supplier.all.order(:corporate_name)
  end

  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end
end
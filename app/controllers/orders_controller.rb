class OrdersController < ApplicationController
  before_action :set_order_and_check_user, only: [:show, :edit, :update, :delivered, :canceled]
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

  def canceled
    @order.canceled!
    redirect_to @order
  end

  def delivered
    @order.delivered!
    @order.order_items.each { |oi| oi.create_stock_product }
    redirect_to @order
  end

  def search
    @code = params[:query]
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  private

  def set_order_and_check_user
    @order = Order.find(params[:id])
    
    if @order.user != current_user
      return redirect_to root_url, alert: t(:order_access_error)
    end
  end

  def set_warehouses_and_suppliers
    @warehouses = Warehouse.all.order(:name)
    @suppliers = Supplier.all.order(:corporate_name)
  end

  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end
end
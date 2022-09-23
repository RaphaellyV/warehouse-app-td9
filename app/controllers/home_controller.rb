class HomeController < ApplicationController
  def index
    @warehouses = Warehouse.all.order(:name)
  end
end
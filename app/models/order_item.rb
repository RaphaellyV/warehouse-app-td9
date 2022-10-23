class OrderItem < ApplicationRecord
  belongs_to :product_model
  belongs_to :order

  validates :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0 }

  def create_stock_product
    self.quantity.times do
      StockProduct.create!(warehouse: order.warehouse, product_model: product_model, 
                           order: order)
    end
  end
end

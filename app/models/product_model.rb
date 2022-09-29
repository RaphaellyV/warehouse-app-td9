class ProductModel < ApplicationRecord
  belongs_to :supplier

  validates :name, :weight, :width, :height, :depth, :sku, presence: true
  validates :sku, length: { is: 20 }
  validates :sku, uniqueness: true
  validates :weight, :width, :height, :depth, numericality: { greater_than: 0 }

  def dimensions
    "#{width} cm x #{depth} cm x #{height} cm"    
  end
end

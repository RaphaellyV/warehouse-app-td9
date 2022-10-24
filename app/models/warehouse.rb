class Warehouse < ApplicationRecord
  has_many :stock_products

  validates :name, :code, :address, :city, :area, :postal_code, :description, :state, presence: true
  validates :name, :code, uniqueness: true
  validates :postal_code, format: { with: /\A\d{5}-{1}\d{3}\z/ }

  def warehouse_full_description
    "#{code} - #{name}"
  end

  def formatted_address
    "#{address} - #{city}/#{state}"
  end
end

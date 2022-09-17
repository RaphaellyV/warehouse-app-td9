class Warehouse < ApplicationRecord
  validates :name, :code, :address, :city, :area, :postal_code, :description, :state, presence: true
  validates :name, :code, uniqueness: true
  validates :postal_code, format: { with: /\A\d{5}-{1}\d{3}\z/ }
end

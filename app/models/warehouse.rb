class Warehouse < ApplicationRecord
  validates :name, :code, :address, :city, :area, :postal_code, :description, presence: true
end

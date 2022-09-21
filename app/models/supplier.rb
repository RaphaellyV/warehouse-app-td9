class Supplier < ApplicationRecord
  validates :brand_name, :corporate_name, :registration_number, :email, presence: true
  validates :registration_number, uniqueness: true
  validates :registration_number, length: { is: 14 }
  validates :postal_code, format: { with: /\A\d{5}-{1}\d{3}\z/ }
end

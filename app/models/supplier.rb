class Supplier < ApplicationRecord
  has_many :product_models
  
  validates :brand_name, :corporate_name, :registration_number, :email, presence: true
  validates :registration_number, uniqueness: true
  validates :registration_number, length: { is: 14 }
  validates :postal_code, format: { with: /\A\d{5}-{1}\d{3}\z/ }

  def supplier_full_description
    "#{brand_name} - #{corporate_name}"
  end

  def formatted_registration_number
    "#{registration_number[0, 2]}.#{registration_number[2, 3]}.#{registration_number[5, 3]}/#{
     registration_number[8, 4]}-#{registration_number[12, 2]}"
  end

  def formatted_address
    "#{full_address} - #{city} - #{state}"
  end
end

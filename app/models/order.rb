class Order < ApplicationRecord
  enum status: { pending: 10, canceled: 20,  delivered: 30}

  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user

  validates :code, :estimated_delivery_date, presence: true
  validates :estimated_delivery_date, comparison: { greater_than: Date.today, message: 'deve ser futura' }

  before_validation :generate_code, on: :create

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(10).upcase
  end
end

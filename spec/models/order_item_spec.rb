require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'quantity is mandatory' do
        # Arrange
        order_item = OrderItem.new(quantity: '')
        
        # Act
        order_item.valid?

        # Assert
        expect(order_item.errors.include? :quantity).to be true
      end
    end

    context 'numericality' do
      it 'quantity must be greater than 0' do
        # Arrange
        order_item = OrderItem.new(quantity: 1)
        
        # Act
        order_item.valid?

        # Assert
        expect(order_item.errors.include? :quantity).to be false
      end

      it 'quantity must not be equal to 0' do
        # Arrange
        order_item = OrderItem.new(quantity: 0)
        
        # Act
        order_item.valid?

        # Assert
        expect(order_item.errors.include? :quantity).to be true
      end

      it 'quantity must not be less than 0' do
        # Arrange
        order_item = OrderItem.new(quantity: -1)
        
        # Act
        order_item.valid?

        # Assert
        expect(order_item.errors.include? :quantity).to be true
      end
    end
  end

  describe '#create_stock_product' do
    it 'creates products in stock for an order' do
      # Arrange
      user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')
    
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                    address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
                                    description: 'Galpão destinado a cargas internacionais.', state: 'SP')                          
      
      supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', 
                                  registration_number: '12300000000100', full_address: 'Av. das Nações Unidas, 1000', 
                                  city: 'São Paulo', state: 'SP', postal_code: '12240-670', email: 'contato@samsung.com.br', 
                                  phone_number: '22998888888')

      product_model = ProductModel.create!(name: 'TV 32', weight: 8_000, width: 70, height: 45, depth: 10, 
                                          sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

      order = Order.create!(estimated_delivery_date: Date.tomorrow, supplier: supplier, 
                            warehouse: warehouse, user: user, status: :pending)
      
      order_item = OrderItem.new(product_model: product_model, order: order, quantity: 5)

      # Act
      order_item.create_stock_product

      # Assert
      expect(StockProduct.where(product_model: product_model, warehouse: warehouse).count).to eq 5
    end
  end
end

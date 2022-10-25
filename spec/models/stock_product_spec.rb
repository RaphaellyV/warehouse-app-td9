require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gera um número de série' do
    it 'ao criar um StockProduct' do
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
                            warehouse: warehouse, user: user, status: :delivered)    
      
      # Act
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product_model)

      # Assert
      expect(stock_product.serial_number.length).to eq 20
    end
    it 'e não é modificado' do
      # Arrange
      user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')
    
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                    address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
                                    description: 'Galpão destinado a cargas internacionais.', state: 'SP')
                                    
      another_warehouse = Warehouse.create!(name: 'Guarulhos', code: 'GSP', city: 'Guarulhos', area: 15_000, 
                                            address: 'Avenida do Aeroporto, 100', postal_code: '10000-000',
                                            description: 'Galpão destinado a cargas internacionais.', state: 'SP')  
      
      supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', 
                                  registration_number: '12300000000100', full_address: 'Av. das Nações Unidas, 1000', 
                                  city: 'São Paulo', state: 'SP', postal_code: '12240-670', email: 'contato@samsung.com.br', 
                                  phone_number: '22998888888')

      product_model = ProductModel.create!(name: 'TV 32', weight: 8_000, width: 70, height: 45, depth: 10, 
                                          sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

      order = Order.create!(estimated_delivery_date: Date.tomorrow, supplier: supplier, 
                            warehouse: warehouse, user: user, status: :delivered)
                    
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product_model)
      original_serial_number = stock_product.serial_number

      # Act
      stock_product.update!(warehouse: another_warehouse)

      # Assert
      expect(stock_product.serial_number).to eq original_serial_number
    end
  end

  describe '#available?' do
    it 'true se não tiver destino' do
      # Arrange
      user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                    address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
                                    description: 'Galpão destinado a cargas internacionais.', state: 'SP')                          

      supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', 
                                  registration_number: '12300000000100', full_address: 'Av. das Nações Unidas, 1000', 
                                  city: 'São Paulo', state: 'SP', postal_code: '12240-670', email: 'contato@samsung.com.br', 
                                  phone_number: '22998888888')

      order = Order.create!(estimated_delivery_date: Date.tomorrow, supplier: supplier, 
                            warehouse: warehouse, user: user, status: :delivered)
      
      tv = ProductModel.create!(name: 'TV 32', weight: 8_000, width: 70, height: 45, depth: 10, 
                                sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

      # Act
      sp = StockProduct.create!(order: order, warehouse: warehouse, product_model: tv)

      # Assert
      expect(sp.available?).to eq true
    end

    it 'false se tiver destino' do
      # Arrange
      user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                    address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
                                    description: 'Galpão destinado a cargas internacionais.', state: 'SP')                          

      supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', 
                                  registration_number: '12300000000100', full_address: 'Av. das Nações Unidas, 1000', 
                                  city: 'São Paulo', state: 'SP', postal_code: '12240-670', email: 'contato@samsung.com.br', 
                                  phone_number: '22998888888')

      order = Order.create!(estimated_delivery_date: Date.tomorrow, supplier: supplier, 
                            warehouse: warehouse, user: user, status: :delivered)
      
      tv = ProductModel.create!(name: 'TV 32', weight: 8_000, width: 70, height: 45, depth: 10, 
                                sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

      # Act
      sp = StockProduct.create!(order: order, warehouse: warehouse, product_model: tv)
      sp.create_stock_product_destination!(recipient: 'Maria', address: 'Rua da Maria, 10')

      # Assert
      expect(sp.available?).to eq false
    end
  end
end

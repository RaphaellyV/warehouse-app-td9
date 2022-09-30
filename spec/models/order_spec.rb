require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'code is mandatory' do
        # Arrange
        order = Order.new()
  
        # Act
        order.valid?
  
        # Assert
        expect(order.errors.include? :code).to be false
      end

      it 'estimated_delivery_date is mandatory' do
        # Arrange
        order = Order.new(estimated_delivery_date: '')
  
        # Act
        order.valid?
  
        # Assert
        expect(order.errors[:estimated_delivery_date]).to include('não pode ficar em branco')
      end 
    end

    context 'comparison' do
      it 'estimated_delivery_date must not be past' do
        # Arrange
        order = Order.new(estimated_delivery_date: Date.yesterday)

        # Act
        order.valid?

        # Assert
        expect(order.errors[:estimated_delivery_date]).to include('deve ser futura')
      end

      it 'estimated_delivery_date must not be present' do
        # Arrange
        order = Order.new(estimated_delivery_date: Date.today)

        # Act
        order.valid?

        # Assert
        expect(order.errors[:estimated_delivery_date]).to include('deve ser futura')
      end

      it 'estimated_delivery_date must be future' do
        # Arrange
        order = Order.new(estimated_delivery_date: Date.tomorrow)

        # Act
        order.valid?

        # Assert
        expect(order.errors[:estimated_delivery_date]).not_to include('deve ser futura')
      end
    end
  end

  describe 'gera um código aleatório ao criar um pedido' do
    it 'ao criar um novo pedido' do
      # Arrange
      user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')
    
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                    address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
                                    description: 'Galpão destinado a cargas internacionais.', state: 'SP')
      
      supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', 
                                  registration_number: '12300000000100', full_address: 'Av. das Nações Unidas, 1000', 
                                  city: 'São Paulo', state: 'SP', postal_code: '12240-670', email: 'contato@samsung.com.br', 
                                  phone_number: '22998888888')
    
      order = Order.new(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: Date.tomorrow)

      # Act
      order.save!
      result = order.code

      # Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 10
    end

    it 'e o código é único' do
      # Arrange
      user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')
    
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                    address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
                                    description: 'Galpão destinado a cargas internacionais.', state: 'SP')
      
      supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', 
                                  registration_number: '12300000000100', full_address: 'Av. das Nações Unidas, 1000', 
                                  city: 'São Paulo', state: 'SP', postal_code: '12240-670', email: 'contato@samsung.com.br', 
                                  phone_number: '22998888888')
    
      first_order = Order.create!(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: Date.tomorrow)
      second_order = Order.new(user: user, supplier: supplier, warehouse: warehouse, estimated_delivery_date: Date.tomorrow)

      # Act
      second_order.save!

      # Assert
      expect(second_order.code).not_to eq first_order.code
    end
  end
end

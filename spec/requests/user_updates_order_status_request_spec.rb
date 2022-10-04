require 'rails_helper'

describe 'Usuário atualiza o status de um pedido' do
  context 'para Entregue' do
    it 'e não está logado' do
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
                                  warehouse: warehouse, user: user, status: :pending)
  
      # Act
      post(delivered_order_path(order.id))
  
      # Assert
      expect(response).to redirect_to(new_user_session_url)
    end

    it 'e não é o dono' do
      # Arrange
      user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')
      other_user = User.create!(name: 'Mariana', email: 'mariana@email.com', password: 'password2')
        
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                    address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
                                    description: 'Galpão destinado a cargas internacionais.', state: 'SP')
        
      supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', 
                                  registration_number: '12300000000102', full_address: 'Av. das Nações Unidas, 1000', 
                                  city: 'São Paulo', state: 'SP', postal_code: '12240-670', email: 'contato@samsung.com.br', 
                                  phone_number: '22998888888')
        
      order = Order.create!(estimated_delivery_date: Date.tomorrow, supplier: supplier, 
                            warehouse: warehouse, user: other_user)
  
      # Act
      login_as user
      post(delivered_order_path(order.id))
      
      # Assert
      expect(response).to redirect_to(root_url)
    end
  end

  context 'para Cancelado' do
    it 'e não está logado' do
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
                                  warehouse: warehouse, user: user, status: :pending)
  
      # Act
      post(canceled_order_path(order.id))
  
      # Assert
      expect(response).to redirect_to(new_user_session_url)
    end

    it 'e não é o dono' do
      # Arrange
      user = User.create!(name: 'Joana', email: 'joana@email.com', password: 'password')
      other_user = User.create!(name: 'Mariana', email: 'mariana@email.com', password: 'password2')
        
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                    address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
                                    description: 'Galpão destinado a cargas internacionais.', state: 'SP')
        
      supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', 
                                  registration_number: '12300000000102', full_address: 'Av. das Nações Unidas, 1000', 
                                  city: 'São Paulo', state: 'SP', postal_code: '12240-670', email: 'contato@samsung.com.br', 
                                  phone_number: '22998888888')
        
      order = Order.create!(estimated_delivery_date: Date.tomorrow, supplier: supplier, 
                            warehouse: warehouse, user: other_user)
  
      # Act
      login_as user
      post(canceled_order_path(order.id))
      
      # Assert
      expect(response).to redirect_to(root_url)
    end
  end
end
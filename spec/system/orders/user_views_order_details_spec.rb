require 'rails_helper'

describe 'Usuário vê detalhes de um pedido' do
  it 'com sucesso' do
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
                                warehouse: warehouse, user: user)

    # Act
    login_as user
    visit root_path
    click_on 'Pedidos'
    click_on order.code

    # Assert
    expect(page).to have_content "Pedido #{order.code}"
    expect(page).to have_content 'Fornecedor'
    expect(page).to have_link 'Samsung - Samsung Eletrônicos LTDA'
    expect(page).to have_content 'Galpão Destino'
    expect(page).to have_link 'GRU - Aeroporto SP'
    expect(page).to have_content "Data Prevista de Entrega: #{Date.tomorrow.strftime("%d/%m/%Y")}"
    expect(page).to have_content 'Usuário Responsável: Pessoa <pessoa@email.com>'
  end

  it 'e volta para a lista de pedidos' do
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
                                warehouse: warehouse, user: user)

    # Act
    login_as user
    visit root_path
    click_on 'Pedidos'
    click_on order.code
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq orders_path
  end
end
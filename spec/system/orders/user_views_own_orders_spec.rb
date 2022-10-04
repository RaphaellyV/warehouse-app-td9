require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
  it 'e deve estar autenticado' do
    # Arrange

    # Act
    visit root_path
    
    # Assert
    expect(page).not_to have_link 'Meus Pedidos'
  end

  it 'a partir da tela inicial' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    # Act
    login_as user
    visit root_path
    within 'nav' do
      click_on 'Meus Pedidos'
    end

    # Assert
    expect(current_path).to eq orders_path
    expect(page).to have_content 'Meus Pedidos'
  end

  it 'e não vê outros pedidos' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')
    other_user = User.create!(name: 'Maria', email: 'maria@email.com', password: 'password2')

    
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                  address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais.', state: 'SP')
    other_warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 150_000, 
                                        address: 'Avenida dos Santos, 150', postal_code: '20000-000',
                                        description: 'Galpão destinado a cargas no Rio.', state: 'RJ')                              
    
    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', 
                                registration_number: '12300000000100', full_address: 'Av. das Nações Unidas, 1000', 
                                city: 'São Paulo', state: 'SP', postal_code: '12240-670', email: 'contato@samsung.com.br', 
                                phone_number: '22998888888')
    other_supplier = Supplier.create!(corporate_name: 'Helena Eletrônicos LTDA', brand_name: 'Helena', 
                                      registration_number: '45600000000100', full_address: 'Av. das Palmeiras, 70', 
                                      city: 'Belo Horizonte', state: 'MG', postal_code: '30240-670', email: 'contato@helena.com.br', 
                                      phone_number: '22998888844')
    
    first_order = Order.create!(estimated_delivery_date: Date.tomorrow, supplier: supplier, 
                                warehouse: warehouse, user: user, status: 'canceled')
    second_order = Order.create!(estimated_delivery_date: 2.weeks.from_now, supplier: other_supplier, 
                                warehouse: other_warehouse, user: other_user, status: 'pending')
    third_order = Order.create!(estimated_delivery_date: 1.week.from_now, supplier: supplier, 
                                warehouse: warehouse, user: user, status: 'delivered')

    # Act
    login_as user
    visit root_path
    within 'nav' do
      click_on 'Meus Pedidos'
    end

    # Assert
    expect(page).to have_content 'Meus Pedidos'
    expect(page).to have_content first_order.code
    expect(page).not_to have_content second_order.code
    expect(page).to have_content third_order.code
    expect(page).to have_content 'Fornecedor'
    expect(page).to have_link 'Samsung - Samsung Eletrônicos LTDA'
    expect(page).not_to have_link 'Helena - Helena Eletrônicos LTDA'
    expect(page).to have_content 'Galpão Destino'
    expect(page).to have_link 'GRU - Aeroporto SP'
    expect(page).not_to have_link 'SDU - Rio'
    expect(page).to have_content 'Data Prevista de Entrega'
    expect(page).to have_content Date.tomorrow.strftime("%d/%m/%Y")
    expect(page).to have_content 1.week.from_now.strftime("%d/%m/%Y")
    expect(page).not_to have_content 2.weeks.from_now.strftime("%d/%m/%Y")
    expect(page).to have_content 'Status'
    expect(page).to have_content 'Cancelado'
    expect(page).to have_content 'Entregue'
    expect(page).not_to have_content 'Pendente'
  end

  it 'e não existem pedidos cadastrados' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    # Act
    login_as user
    visit root_path
    click_on 'Meus Pedidos'

    # Assert
    expect(page).to have_content 'Não existem pedidos cadastrados.'
  end

  it 'e não vista pedidos de outros usuários' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')
    other_user = User.create!(name: 'Maria', email: 'maria@email.com', password: 'password2')

    
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                  address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais.', state: 'SP')
    
    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', 
                                registration_number: '12300000000100', full_address: 'Av. das Nações Unidas, 1000', 
                                city: 'São Paulo', state: 'SP', postal_code: '12240-670', email: 'contato@samsung.com.br', 
                                phone_number: '22998888888')
    
    order = Order.create!(estimated_delivery_date: Date.tomorrow, supplier: supplier, 
                          warehouse: warehouse, user: other_user)

    # Act
    login_as user
    visit order_path(order.id)

    # Assert
    expect(current_path).not_to eq order_path(order.id)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a este pedido.'
  end
end
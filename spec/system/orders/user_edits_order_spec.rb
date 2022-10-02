require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e deve estar autenticado' do
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
    visit order_path(order.id)

    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir da página de detalhes' do
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
    click_on 'Editar Pedido'

    # Assert
    expect(page).to have_content 'Editar Pedido'
    expect(page).to have_field('Data Prevista de Entrega', with: Date.tomorrow)
    expect(page).to have_select('Fornecedor', selected: 'Samsung - Samsung Eletrônicos LTDA')
    expect(page).to have_select('Galpão Destino', selected: 'GRU - Aeroporto SP')
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')
    
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                  address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais.', state: 'SP')
    Warehouse.create!(name: 'Maceió', code: 'MCZ',  city: 'Maceió', area: 50_000, state: 'AL',
                      description: 'Galpão de Maceió.', postal_code: '80000-000', address: 'Av. Atlântica, 50')                          
    
    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', 
                                registration_number: '12300000000100', full_address: 'Av. das Nações Unidas, 1000', 
                                city: 'São Paulo', state: 'SP', postal_code: '12240-670', email: 'contato@samsung.com.br', 
                                phone_number: '22998888888')
    Supplier.create!(corporate_name: 'Stark Industries LTDA', brand_name: 'Stark', registration_number: '11000000000100', 
                     full_address: 'Torre da Indústria, 1', city: 'Teresina', state: 'PI', postal_code: '64000-020',
                     email: 'contato@stark.com', phone_number: '22999994445')
    
    order = Order.create!(estimated_delivery_date: Date.tomorrow, supplier: supplier, 
                                warehouse: warehouse, user: user)

    # Act
    login_as user
    visit root_path
    click_on 'Pedidos'
    click_on order.code
    click_on 'Editar Pedido'
    select 'MCZ - Maceió', from: 'Galpão Destino'
    select 'Stark - Stark Industries LTDA', from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: 1.month.from_now.strftime("%d/%m/%Y")
    click_on 'Atualizar Pedido'

    # Assert
    expect(page).to have_content 'Pedido atualizado com sucesso!'
    expect(page).to have_content 'Galpão Destino: MCZ - Maceió'
    expect(page).to have_content 'Fornecedor: Stark - Stark Industries LTDA'
    expect(page).to have_content 'Usuário Responsável: Pessoa <pessoa@email.com>'
    expect(page).to have_content "Data Prevista de Entrega: #{1.month.from_now.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Pedido #{order.code}"
  end

  it 'e mantém os campos obrigatórios' do
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
    click_on 'Editar Pedido'
    select '', from: 'Galpão Destino'
    select '', from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: ''
    click_on 'Atualizar Pedido'

    # Assert
    expect(page).to have_content 'Não foi possível atualizar o Pedido.'
    expect(page).to have_content 'Editar Pedido'
  end

  it 'e não é o usuário responsável' do
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
                          warehouse: warehouse, user: user)
    
    # Act
    login_as other_user
    visit edit_order_path(order.id)
    
    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a este pedido.'
  end
end
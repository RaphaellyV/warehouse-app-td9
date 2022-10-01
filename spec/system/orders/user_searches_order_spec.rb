require 'rails_helper'

describe 'Usuário busca por um pedido' do
  it 'e deve estar autenticado' do
    # Arrange

    # Act
    visit root_path

    # Assert
    within 'header nav' do
      expect(page).not_to have_field 'Buscar Pedido'
      expect(page).not_to have_button 'Buscar'
    end
  end

  it 'a partir do menu' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    # Act
    login_as user
    visit root_path

    # Assert
    within 'header nav' do
      expect(page).to have_field 'Buscar Pedido'
      expect(page).to have_button 'Buscar'
    end
  end

  it 'e encontra um pedido' do
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
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'

    # Assert
    expect(page).to have_content "Resultados da Busca por: #{order.code}" 
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código"
    expect(page).to have_link order.code
    expect(page).to have_content "Data Prevista de Entrega"
    expect(page).to have_content Date.tomorrow.strftime("%d/%m/%Y")
    expect(page).to have_content 'Galpão Destino'
    expect(page).to have_link 'GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor'
    expect(page).to have_link 'Samsung - Samsung Eletrônicos LTDA'
  end

  it 'e não encontra o pedido' do
    # Arrange 
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    # Act
    login_as user
    visit root_path
    fill_in 'Buscar Pedido', with: ''
    click_on 'Buscar'

    # Assert
    expect(page).to have_content "Resultados da Busca por:" 
    expect(page).to have_content 'Não foi possível encontrar o pedido.'
  end

  it 'e encontra múltiplos pedidos' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    first_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                        address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
                                        description: 'Galpão destinado a cargas internacionais.', state: 'SP') 
    second_warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ',  city: 'Maceió', area: 50_000, state: 'AL',
                                         description: 'Galpão de Maceió.', postal_code: '80000-000', address: 'Av. Atlântica, 50')                         

    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', 
                                registration_number: '12300000000100', full_address: 'Av. das Nações Unidas, 1000', 
                                city: 'São Paulo', state: 'SP', postal_code: '12240-670', email: 'contato@samsung.com.br', 
                                phone_number: '22998888888')

    allow(SecureRandom).to receive(:alphanumeric).and_return('GRU3456789')
    first_order = Order.create!(estimated_delivery_date: Date.tomorrow, supplier: supplier, 
                                warehouse: first_warehouse, user: user)
    
    allow(SecureRandom).to receive(:alphanumeric).and_return('GRU3456779')
    second_order = Order.create!(estimated_delivery_date: Date.tomorrow, supplier: supplier, 
                                 warehouse: first_warehouse, user: user)
    
    allow(SecureRandom).to receive(:alphanumeric).and_return('MCZ3456789')                      
    third_order = Order.create!(estimated_delivery_date: Date.tomorrow, supplier: supplier, 
                                warehouse: second_warehouse, user: user)

    # Act
    login_as user
    visit root_path
    fill_in 'Buscar Pedido', with: 'GRU'
    click_on 'Buscar'

    # Assert
    expect(page).to have_content '2 pedidos encontrados'
    expect(page).to have_content 'GRU3456789'
    expect(page).to have_content 'GRU3456779'
    expect(page).to have_link 'GRU - Aeroporto SP'
    expect(page).not_to have_content 'MCZ3456789'
    expect(page).not_to have_link 'MCZ - Maceió'
  end
end
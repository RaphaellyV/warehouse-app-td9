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
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content "Data Prevista de Entrega: #{Date.tomorrow.strftime("%d/%m/%Y")}"
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: Samsung - Samsung Eletrônicos LTDA'
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
end
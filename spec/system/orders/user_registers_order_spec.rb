require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'e deve estar autenticado' do
    # Arrange

    # Act
    visit new_order_path

    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')
    
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                  address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais.', state: 'SP')
    Warehouse.create!(name: 'Maceió', code: 'MCZ',  city: 'Maceió', area: 50_000, state: 'AL',
                      description: 'Galpão de Maceió.', postal_code: '80000-000', address: 'Av. Atlântica, 50')
              
    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                email: 'contato@samsung.com.br', phone_number: '22998888888')
    Supplier.create!(corporate_name: 'Stark Industries LTDA', brand_name: 'Stark', registration_number: '11000000000100', 
                     full_address: 'Torre da Indústria, 1', city: 'Teresina', state: 'PI', postal_code: '64000-020',
                     email: 'contato@stark.com', phone_number: '22999994445')
             
    # Act
    login_as user
    visit root_path
    click_on 'Pedidos'
    click_on 'Novo Pedido'
    select 'GRU - Aeroporto SP', from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: Date.tomorrow.strftime("%d/%m/%Y")
    click_on 'Criar Pedido'

    # Assert
    expect(page).to have_content 'Pedido cadastrado com sucesso!'
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: Samsung - Samsung Eletrônicos LTDA'
    expect(page).to have_content 'Usuário Responsável: Pessoa <pessoa@email.com>'
    expect(page).to have_content "Data Prevista de Entrega: #{Date.tomorrow.strftime("%d/%m/%Y")}"
    expect(page).not_to have_content 'Maceió'
    expect(page).not_to have_content 'Stark Industries LTDA'
  end
end
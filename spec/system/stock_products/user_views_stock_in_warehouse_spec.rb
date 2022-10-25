require 'rails_helper'

describe 'Usuário vê o estoque' do
  it 'na tela do galpão' do
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

    soundbar = ProductModel.create!(name: 'Soundbar 7.1', weight: 3_000, width: 80, height: 15, depth: 20, 
                                    sku: 'SOUND-SAMSUNG-XPTO90', supplier: supplier)

    notebook = ProductModel.create!(name: 'Notebook i5', weight: 2_000, width: 40, height: 9, depth: 20, 
                                    sku: 'NOTEi5-SAMSUNG-XPT90', supplier: supplier)

    3.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: tv) }
    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: notebook) }

    # Act
    login_as user
    visit root_path
    click_on 'Aeroporto SP'

    # Assert
    expect(page).to have_content 'Itens no Estoque'
    expect(page).to have_content '3 x TV32P-SAMSUNG-XPTO90'
    expect(page).to have_content '2 x NOTEi5-SAMSUNG-XPT90'
    expect(page).not_to have_content 'SOUND-SAMSUNG-XPTO90'
  end

  it 'e dá baixa em um item' do
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

    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: tv) }
    
    # Act
    login_as user
    visit root_path
    click_on 'Aeroporto SP'
    select 'TV32P-SAMSUNG-XPTO90', from: 'Item para Saída'
    fill_in 'Destinatário', with: 'Maria Pereira'
    fill_in 'Endereço Destino', with: 'Rua das Palmeiras, 100 - Campinas - SP'
    click_on 'Confirmar Retirada'

    # Assert
    expect(current_path).to eq warehouse_path(warehouse.id)
    expect(page).to have_content 'Item retirado com sucesso'
    expect(page).to have_content '1 x TV32P-SAMSUNG-XPTO90'
  end

  # Novo teste
end


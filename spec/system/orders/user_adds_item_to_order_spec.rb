require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
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
    
    product_a = ProductModel.create!(name: 'Produto A', weight: 8_000, width: 70, height: 45, depth: 10, 
                                     sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

    product_b = ProductModel.create!(name: 'Produto B', weight: 8_000, width: 70, height: 45, depth: 10, 
                                      sku: 'TV40P-SAMSUNG-XPTO90', supplier: supplier)
                                  
    order = Order.create!(estimated_delivery_date: Date.tomorrow, supplier: supplier, 
                          warehouse: warehouse, user: user)

    # Act
    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    select 'Produto A', from: 'Produto'
    fill_in 'Quantidade', with: 8
    click_on 'Adicionar Item'

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '8 x Produto A'
  end

  it 'e não vê produtos de outro fornecedor' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')
    
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                                  address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
                                  description: 'Galpão destinado a cargas internacionais.', state: 'SP')                          
    
    supplier_a = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', 
                                registration_number: '12300000000100', full_address: 'Av. das Nações Unidas, 1000', 
                                city: 'São Paulo', state: 'SP', postal_code: '12240-670', email: 'contato@samsung.com.br', 
                                phone_number: '22998888888')
    
    supplier_b = Supplier.create!(corporate_name: 'Motorola Eletrônicos LTDA', brand_name: 'Motorola', 
                                  registration_number: '12300000000111', full_address: 'Av. das Nações Unidas, 1020', 
                                  city: 'São Paulo', state: 'SP', postal_code: '12240-670', email: 'contato@motorola.com.br', 
                                  phone_number: '22998888888')
    
    product_a = ProductModel.create!(name: 'Produto A', weight: 8_000, width: 70, height: 45, depth: 10, 
                                     sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier_a)

    product_b = ProductModel.create!(name: 'Produto B', weight: 8_000, width: 70, height: 45, depth: 10, 
                                      sku: 'TV40P-MOTOUNG-XPTO90', supplier: supplier_b)
                                  
    order = Order.create!(estimated_delivery_date: Date.tomorrow, supplier: supplier_a, 
                          warehouse: warehouse, user: user)

    # Act
    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    # Assert
    expect(page).to have_content 'Produto A'
    expect(page).not_to have_content 'Produto B'
  end
end
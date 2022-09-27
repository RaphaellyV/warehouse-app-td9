require 'rails_helper'

describe 'Usuário vê modelos de produtos' do
  it 'se estiver autenticado' do
    # Arrange

    # Act
    visit product_models_path

    # Assist
    expect(current_path).to eq new_user_session_path
  end

  it 'a partir do menu' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    # Act
    login_as user
    visit root_path
    within 'nav' do
      click_on 'Produtos'
    end

    # Assert
    expect(current_path).to eq product_models_path
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                               full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                               email: 'contato@samsung.com.br', phone_number: '22998888888')
    ProductModel.create!(name: 'TV 32', weight: 8_000, width: 70, height: 45, depth: 10, 
                          sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)
    ProductModel.create!(name:'Soundbar 7.1 Surround', weight: 3_000, width: 80, height: 15, 
                          depth: 10, sku: 'SOU71PP-SAMSU-NOIZ77', supplier: supplier)

    # Act
    login_as user
    visit root_path
    within 'nav' do
      click_on 'Produtos'
    end

    # Assert
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32P-SAMSUNG-XPTO90'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'Soundbar 7.1 Surround'
    expect(page).to have_content 'SOU71PP-SAMSU-NOIZ77'
    expect(page).to have_content 'Samsung'
  end

  it 'e não existem produtos cadastrados' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    # Act
    login_as user
    visit root_path
    within 'nav' do
      click_on 'Produtos'
    end

    # Assert
    expect(page).to have_content 'Não existem produtos cadastrados.'
  end

  it 'e acessa a página de detalhes do fornecedor' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                email: 'contato@samsung.com.br', phone_number: '22998888888')
    ProductModel.create!(name: 'TV 32', weight: 8_000, width: 70, height: 45, depth: 10, 
                         sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

    # Act
    login_as user
    visit root_path
    within 'nav' do
    click_on 'Produtos'
    end 
    click_on 'Samsung'

    # Assert
    expect(current_path).to eq supplier_path(supplier)
  end
end
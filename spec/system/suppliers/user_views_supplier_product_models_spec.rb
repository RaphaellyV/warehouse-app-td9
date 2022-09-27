require 'rails_helper'

describe 'Usuário vê modelos de produto do fornecedor' do
  it 'com sucesso' do
    # Arrange
    User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                email: 'contato@samsung.com.br', phone_number: '22998888888')
    ProductModel.create!(name: 'TV 32', weight: 8_000, width: 70, height: 45, depth: 10, 
                         sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)
    ProductModel.create!(name:'Soundbar 7.1 Surround', weight: 3_000, width: 80, height: 15, 
                         depth: 10, sku: 'SOU71PP-SAMSU-NOIZ77', supplier: supplier)

    # Act
    visit root_path
    within 'nav' do
      click_on 'Entrar'
    end
    within 'form' do
      fill_in 'E-mail', with: 'pessoa@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Fornecedores'
    click_on 'Samsung'

    # Assert
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'SKU: TV32P-SAMSUNG-XPTO90'
    expect(page).to have_content 'Peso: 8 kg'
    expect(page).to have_content 'Dimensões: 70 cm x 10 cm x 45 cm'
    expect(page).to have_content 'Soundbar 7.1 Surround'
    expect(page).to have_content 'SOU71PP-SAMSU-NOIZ77'
    expect(page).to have_content 'Peso: 3 kg'
    expect(page).to have_content 'Dimensões: 80 cm x 10 cm x 15 cm'
  end

  it 'e não existem modelos de produto cadastrados' do
    # Arrange
    User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                email: 'contato@samsung.com.br', phone_number: '22998888888')

    # Act
    visit root_path
    within 'nav' do
      click_on 'Entrar'
    end
    within 'form' do
      fill_in 'E-mail', with: 'pessoa@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Fornecedores'
    click_on 'Samsung'

    # Assert
    expect(page).to have_content 'Não existem Modelos de Produto cadastrados para este Fornecedor'
  end

  it 'e não vê modelos de produto de outros fornecedores' do
    # Arrange
    User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                email: 'contato@samsung.com.br', phone_number: '22998888888')
    other_supplier = Supplier.create!(corporate_name: 'Stark Industries LTDA', brand_name: 'Stark', registration_number: '11000000000100', 
                                      full_address: 'Torre da Indústria, 1', city: 'Teresina', state: 'PI', postal_code: '64000-020',
                                      email: 'contato@stark.com', phone_number: '22999994445')
    
    ProductModel.create!(name: 'TV 32', weight: 8_000, width: 70, height: 45, depth: 10, 
                         sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)
    ProductModel.create!(name:'Soundbar 7.1 Surround', weight: 3_000, width: 80, height: 15, 
                         depth: 10, sku: 'SOU71PP-STARK-NOIZ77', supplier: other_supplier)

    # Act
    visit root_path
    within 'nav' do
      click_on 'Entrar'
    end
    within 'form' do
      fill_in 'E-mail', with: 'pessoa@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Fornecedores'
    click_on supplier.brand_name

    # Assert
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32P-SAMSUNG-XPTO90'
    expect(page).not_to have_content 'Soundbar 7.1 Surround'
    expect(page).not_to have_content 'SOU71PP-STARK-NOIZ77'
  end
end
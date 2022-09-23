require 'rails_helper'
describe 'Usuário vê detalhes de um modelo de produto' do
  it 'com sucesso' do
    # Arrange
    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                email: 'contato@samsung.com.br', phone_number: '22998888888')
    product_model = ProductModel.create!(name: 'TV 32', weight: 8_000, width: 70, height: 45, depth: 10, 
                                         sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

    # Act
    visit root_path
    within 'nav' do
      click_on 'Produtos'
    end 
    click_on 'TV 32'

    # Assert
    expect(page).to have_content 'Produto: TV 32'
    expect(page).to have_content 'SKU: TV32P-SAMSUNG-XPTO90'
    expect(page).to have_content 'Dimensões: 70 cm x 10 cm x 45'
    expect(page).to have_content 'Peso: 8 kg'
    expect(page).to have_content 'Fornecedor: Samsung'
  end

  it 'e retorna para a lista de modelos de produtos' do
    # Arrange
    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                email: 'contato@samsung.com.br', phone_number: '22998888888')
    product_model = ProductModel.create!(name: 'TV 32', weight: 8_000, width: 70, height: 45, depth: 10, 
                                         sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

    # Act
    visit root_path
    within 'nav' do
    click_on 'Produtos'
    end 
    click_on 'TV 32'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq product_models_path
  end

  it 'e acessa a página de detalhes do fornecedor' do
    # Arrange
    supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                email: 'contato@samsung.com.br', phone_number: '22998888888')
    ProductModel.create!(name: 'TV 32', weight: 8_000, width: 70, height: 45, depth: 10, 
                         sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

    # Act
    visit root_path
    within 'nav' do
    click_on 'Produtos'
    end 
    click_on 'TV 32'
    click_on 'Samsung'

    # Assert
    expect(current_path).to eq supplier_path(supplier)
  end
end
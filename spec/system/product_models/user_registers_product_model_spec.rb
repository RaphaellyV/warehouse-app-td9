require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
  it 'a partir da tela inicial' do
    # Arrange
    User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

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
    within 'nav' do
      click_on 'Produtos'
    end
    click_on 'Cadastrar Modelo de Produto'

    # Assert
    expect(page).to have_content('Nome')
    expect(page).to have_content('Peso')
    expect(page).to have_content('Comprimento')
    expect(page).to have_content('Altura')
    expect(page).to have_content('Largura')
    expect(page).to have_content('SKU')
    expect(page).to have_content('Fornecedor')
  end

  it 'com sucesso' do
    # Arrange
    User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                     full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                     email: 'contato@samsung.com.br', phone_number: '22998888888')
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '00000000000100', 
                     full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', postal_code: '12240-670', 
                     email: 'contato@acme.com.br', phone_number: '22999994444')

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
    click_on 'Produtos'
    click_on 'Cadastrar Modelo de Produto'
    fill_in 'Nome', with: 'TV 40 polegadas'
    fill_in 'SKU', with: 'TV40P-SAMSUNG-XPTO90'
    fill_in 'Peso', with: 10_000
    fill_in 'Altura', with: 60
    fill_in 'Largura', with: 10
    fill_in 'Comprimento', with: 90
    select 'Samsung', from: 'Fornecedor'
    click_on 'Criar Modelo de Produto'

    # Assert
    expect(page).to have_content('Modelo de Produto cadastrado com sucesso!')
    expect(page).to have_content('Produto: TV 40 polegadas')
    expect(page).to have_content('SKU: TV40P-SAMSUNG-XPTO90')
    expect(page).to have_content('Dimensões: 90 cm x 10 cm x 60 cm')
    expect(page).to have_content('Peso: 10 kg')
    expect(page).to have_content('Fornecedor: Samsung')
  end

  it 'com dados incompletos' do
    # Arrange
    User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

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
    click_on 'Produtos'
    click_on 'Cadastrar Modelo de Produto'
    fill_in 'Nome', with: ''
    fill_in 'SKU', with: ''
    click_on 'Criar Modelo de Produto'

    # Assert
    expect(page).to have_content('Não foi possível cadastrar o Modelo de Produto.')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('SKU não pode ficar em branco')
  end
end
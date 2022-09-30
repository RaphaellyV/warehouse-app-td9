require 'rails_helper'

describe 'Usuário edita um fornecedor' do
  it 'a partir da página de detalhes' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '00000000000100', 
                     full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', postal_code: '12240-670', 
                     email: 'contato@acme.com.br', phone_number: '22999994444')

    # Act
    login_as user
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'ACME'
    click_on 'Editar Fornecedor'

    # Assert
    expect(page).to have_content 'Editar Fornecedor'
    expect(page).to have_field('Razão Social', with: 'ACME LTDA')
    expect(page).to have_field('Nome Fantasia', with: 'ACME')
    expect(page).to have_field('CNPJ', with: '00000000000100')
    expect(page).to have_field('Endereço', with: 'Av. das Palmas, 100')
    expect(page).to have_field('Cidade', with: 'Bauru')
    expect(page).to have_field('Estado', with: 'SP')
    expect(page).to have_field('CEP', with: '12240-670')
    expect(page).to have_field('E-mail', with: 'contato@acme.com.br')
    expect(page).to have_field('Telefone', with: '22999994444')
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '00000000000100', 
                     full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', postal_code: '12240-670', 
                     email: 'contato@acme.com.br', phone_number: '22999994444')

    # Act
    login_as user
    visit root_path
    within 'nav' do
    click_on 'Fornecedores'
    end
    click_on 'ACME'
    click_on 'Editar Fornecedor'
    fill_in 'Razão Social', with: 'ALAMEDA LTDA'
    fill_in 'Nome Fantasia', with: 'ALAMEDA'
    fill_in 'CNPJ', with: '03250000000100'
    fill_in 'Endereço', with: 'Av. das Estradas, 101'
    fill_in 'Cidade', with: 'Campos'
    fill_in 'Estado', with: 'RJ'
    fill_in 'CEP', with: '12240-555'
    fill_in 'E-mail', with: 'contato@alameda.com.br'
    fill_in 'Telefone', with: '22999994455'
    click_on 'Atualizar Fornecedor'

    # Assert
    expect(page).to have_content 'Fornecedor atualizado com sucesso!'
    expect(page).to have_content 'ALAMEDA'
    expect(page).to have_content 'ALAMEDA LTDA'
    expect(page).to have_content 'CNPJ: 03.250.000/0001-00'
    expect(page).to have_content 'Endereço: Av. das Estradas, 101 - Campos - RJ'
    expect(page).to have_content 'CEP: 12.240-555'
    expect(page).to have_content 'E-mail: contato@alameda.com.br'
    expect(page).to have_content 'Telefone: (22) 99999-4455'
  end

  it 'e mantém os campos obrigatórios' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')
    
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '00000000000100', 
                     full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', postal_code: '12240-670', 
                     email: 'contato@acme.com.br', phone_number: '22999994444')

    # Act
    login_as user
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'ACME'
    click_on 'Editar Fornecedor'
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'CEP', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Telefone', with: ''
    click_on 'Atualizar Fornecedor'

    # Assert
    expect(page).to have_content 'Editar Fornecedor'
    expect(page).to have_content 'Não foi possível atualizar o fornecedor.'
  end
end
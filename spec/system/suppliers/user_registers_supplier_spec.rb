require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
  it 'a partir da tela inicial' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    # Act
    login_as user
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar Fornecedor'

    # Assert
    expect(page).to have_content('Razão Social')
    expect(page).to have_content('Nome Fantasia')
    expect(page).to have_content('CNPJ')
    expect(page).to have_content('Endereço')
    expect(page).to have_content('Cidade')
    expect(page).to have_content('Estado')
    expect(page).to have_content('CEP')
    expect(page).to have_content('E-mail')
    expect(page).to have_content('Telefone')
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    # Act
    login_as user
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar Fornecedor'
    fill_in 'Razão Social', with: 'ACME LTDA'
    fill_in 'Nome Fantasia', with: 'ACME'
    fill_in 'CNPJ', with: '00000000000100'
    fill_in 'Endereço', with: 'Av. das Palmas, 100'
    fill_in 'Cidade', with: 'Bauru'
    fill_in 'Estado', with: 'SP'
    fill_in 'CEP', with: '12240-670'
    fill_in 'E-mail', with: 'contato@acme.com.br'
    fill_in 'Telefone', with: '22999994444'
    click_on 'Criar Fornecedor'

    # Assert
    expect(page).to have_content 'Fornecedor cadastrado com sucesso!'
    expect(page).to have_content 'ACME'
    expect(page).to have_content 'ACME LTDA'
    expect(page).to have_content 'CNPJ: 00.000.000/0001-00'
    expect(page).to have_content 'Endereço: Av. das Palmas, 100 - Bauru - SP'
    expect(page).to have_content 'CEP: 12.240-670'
    expect(page).to have_content 'E-mail: contato@acme.com.br'
    expect(page).to have_content 'Telefone: (22) 99999-4444'
  end

  it 'com dados incompletos' do
    #Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    #Act
    login_as user
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar Fornecedor'
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'CEP', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Telefone', with: ''
    click_on 'Criar Fornecedor'

    #Assert
    expect(page).to have_content 'Fornecedor não cadastrado.'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
  end
end
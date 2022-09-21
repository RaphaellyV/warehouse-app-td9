require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
  it 'a partir da tela inicial' do
    # Arrange

    # Act
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
  end

  it 'com sucesso' do
    # Arrange

    # Act
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

    # Assert
  end
  
end
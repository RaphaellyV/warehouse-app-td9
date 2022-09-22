require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor ' do
  it 'a partir do menu' do
    # Arrange

    # Act
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    
    # Arrange
    expect(current_path).to eq suppliers_path
  end

  it 'com sucesso' do
    # Arrange
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '00000000000100', 
                     full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', postal_code: '12240-670', 
                     email: 'contato@acme.com.br', phone_number: '22999994444')

    # Act
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'ACME'

    # Assert
    expect(page).to have_content 'ACME'
    expect(page).to have_content 'ACME LTDA'
    expect(page).to have_content 'CNPJ: 00.000.000/0001-00'
    expect(page).to have_content 'Endereço: Av. das Palmas, 100 - Bauru - SP'
    expect(page).to have_content 'CEP: 12.240-670'
    expect(page).to have_content 'E-mail: contato@acme.com.br'
    expect(page).to have_content 'Telefone: (22) 99999-4444'
  end

  it 'e volta para a lista de fornecedores' do
    # Arrange
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '00000000000100', 
                     full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', postal_code: '12240-670', 
                     email: 'contato@acme.com.br', phone_number: '22888888888')

    # Act
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end
    click_on 'ACME'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq suppliers_path
  end
end
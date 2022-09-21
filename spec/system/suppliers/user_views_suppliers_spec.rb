require 'rails_helper'

describe 'Usuário vê fornecedores' do
  it 'a partir do menu' do
    # Arrange

    # Act
    visit root_path
    within 'nav' do
      click_on 'Fornecedores'
    end

    #Assert
    expect(current_path).to eq suppliers_path
  end

  it 'com sucesso' do
    # Arrange
    Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '00000000000100', 
                     full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', postal_code: '12240-670', 
                     email: 'contato@acme.com.br', phone_number: '22999994444')
    Supplier.create!(corporate_name: 'Stark Industries LTDA', brand_name: 'Stark', registration_number: '11000000000100', 
                     full_address: 'Torre da Indústria, 1', city: 'Teresina', state: 'PI', postal_code: '64000-020',
                     email: 'contato@stark.com', phone_number: '22999994445')

    # Act
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end

    # Assert
    within('main') do
      expect(page).to have_content 'Fornecedores'
    end
    expect(page).to have_content 'ACME'
    expect(page).to have_content 'Bauru - SP'
    expect(page).to have_content 'Stark'
    expect(page).to have_content 'Teresina - PI'
  end

  it 'e não existem fornecedores cadastrados' do
    # Arrange

    # Act
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end

    # Assert
    expect(page).to have_content 'Não existem fornecedores cadastrados.'
  end
end
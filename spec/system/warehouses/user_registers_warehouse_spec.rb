require 'rails_helper'

describe 'Usuário cadastra um galpão' do
  it 'a partir da tela inicial' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    # Act
    login_as user
    visit root_path
    click_on 'Cadastrar Galpão'

    # Assert
    expect(page).to have_field('Nome')
    expect(page).to have_field('Código')
    expect(page).to have_field('Descrição')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('Área')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('CEP')
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    # Act
    login_as user
    visit root_path
    click_on 'Cadastrar Galpão'
    fill_in 'Nome', with: 'Rio de Janeiro'
    fill_in 'Código', with: 'RIO'
    fill_in 'Descrição', with: 'Galpão da área da zona portuária.'
    fill_in 'Cidade', with: 'Rio de Janeiro'
    fill_in 'Estado', with: 'RJ'
    fill_in 'Área', with: '32000'
    fill_in 'Endereço', with: 'Avenida do Museu do Amanhã, 1000'
    fill_in 'CEP', with: '20100-000'
    click_on 'Criar Galpão'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão cadastrado com sucesso!'
    expect(page).to have_content 'Rio de Janeiro'
    expect(page).to have_content 'RJ'
    expect(page).to have_content 'RIO'
    expect(page).to have_content '32.000 m²'
  end

  it 'com dados incompletos' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    # Act
    login_as user
    visit root_path
    click_on 'Cadastrar Galpão'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'Área', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'CEP', with: ''
    click_on 'Criar Galpão'
    
    # Assert
    expect(page).to have_content 'Não foi possível cadastrar o Galpão.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Código não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
    expect(page).to have_content 'Área não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'CEP não pode ficar em branco'
  end
end
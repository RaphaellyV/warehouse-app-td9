require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
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

    # Assert
    within 'nav' do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Pessoa'
    end
      expect(page).to have_content 'Login efetuado com sucesso.'
  end

  it 'e faz logout' do
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
    click_on 'Sair'

    # Assert
    within 'nav' do
      expect(page).to have_link 'Entrar'
      expect(page).not_to have_button 'Sair'
      expect(page).not_to have_content 'Pessoa'
      expect(page).not_to have_content 'Fornecedores'
      expect(page).not_to have_content 'Produtos'
    end
      expect(page).to have_content 'Logout efetuado com sucesso.'
  end
end
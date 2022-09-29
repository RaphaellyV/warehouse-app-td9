require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it 'name is mandatory' do
      # Arrange
      user = User.new(name: '', email:'pessoa@email.com', password: 'password')

      # Act

      # Assert
      expect(user.valid?).to eq false
    end

    it 'email is unique' do
      # Arrange
      User.create!(name: 'Pessoa', email:'pessoa@email.com', password: 'password')
      user = User.new(name: 'Outra Pessoa', email:'pessoa@email.com', password: 'password2')

      # Act

      # Assert
      expect(user.valid?).to eq false
    end
  end

  describe '#user_full_description' do
    it 'exibe o nome e o e-mail' do
      # Arrange
      user = User.new(name: 'Pessoa', email: 'pessoa@email.com')

      # Act
      
      # Assert
      expect(user.user_full_description).to eq 'Pessoa <pessoa@email.com>'
    end
  end
end

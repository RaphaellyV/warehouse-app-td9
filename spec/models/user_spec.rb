require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it 'name is mandatory' do
      # Arrange
      user = User.new(name: '')

      # Act
      user.valid?

      # Assert
      expect(user.errors.include? :name).to be true
    end

    it 'email is unique' do
      # Arrange
      User.create!(name: 'Pessoa', email:'pessoa@email.com', password: 'password')
      user = User.new(email:'pessoa@email.com')

      # Act
      user.valid?

      # Assert
      expect(user.errors.include? :email).to be true
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

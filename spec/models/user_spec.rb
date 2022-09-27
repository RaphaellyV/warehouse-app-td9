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
end

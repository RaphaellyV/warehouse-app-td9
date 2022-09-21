require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when corporate_name is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: '', brand_name: 'ACME', registration_number: '00000000000100', 
                                full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', postal_code: '12240-670', 
                                email: 'contato@acme.com.br', phone_number: '22999994444')
        
        # Act

        # Assert
        expect(supplier.valid?).to eq false
      end

      it 'false when brand_name is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: '', registration_number: '00000000000100', 
                                full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', postal_code: '12240-670', 
                                email: 'contato@acme.com.br', phone_number: '22999994444')

        # Act

        # Assert
        expect(supplier.valid?).to eq false
      end

      it 'false when registration_number is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '', 
                                full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', postal_code: '12240-670', 
                                email: 'contato@acme.com.br', phone_number: '22999994444')

        # Act

        # Assert
        expect(supplier.valid?).to eq false
      end

      it 'false when email is empty' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '00000000000100', 
                                full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', postal_code: '12240-670', 
                                email: '', phone_number: '22999994444')

        # Act

        # Assert
        expect(supplier.valid?).to eq false
      end
    end

    context 'uniqueness' do
      # Arrange
      it 'false when registration_number is already in use' do
        first_supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '00000000000100', 
                                          full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', postal_code: '12240-670', 
                                          email: 'contato@acme.com.br', phone_number: '22999994444')
        second_supplier = Supplier.new(corporate_name: 'ALAMEDA LTDA', brand_name: 'ALAMEDA', registration_number: '00000000000100', 
                                       full_address: 'Av. da Estrada, 102', city: 'Campinas', state: 'SP', postal_code: '13010-110', 
                                       email: 'contato@alameda.com.br', phone_number: '22999995555')
      
        # Act

        # Assert
        expect(second_supplier.valid?).to eq false
      end
    end

    context 'length' do
      it 'false when registration_number is long' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '000000000000100', 
                                full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', postal_code: '12240-670', 
                                email: 'contato@acme.com', phone_number: '22999994444')
      
        # Act

        # Assert
        expect(supplier.valid?).to eq false
      end

      it 'false when registration_number is short' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '000000000100', 
                                full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', postal_code: '12240-670', 
                                email: 'contato@acme.com', phone_number: '22999994444')
      
        # Act

        # Assert
        expect(supplier.valid?).to eq false
      end
    end
  end
end

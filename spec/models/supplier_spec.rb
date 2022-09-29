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

    context 'format' do
      it 'false when postal code is short' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '00000000000100', 
                                full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', postal_code: '12240-67', 
                                email: 'contato@acme.com.br', phone_number: '22999994444')

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when postal code is long' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '00000000000100', 
                                full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', postal_code: '12240-6700', 
                                email: 'contato@acme.com.br', phone_number: '22999994444')

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when postal code has no -' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '00000000000100', 
                                full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', postal_code: '12240670', 
                                email: 'contato@acme.com.br', phone_number: '22999994444')

        # Act
        result = supplier.valid?

        # Assert
        expect(result).to eq false
      end
    end
  end

  describe '#supplier_full_description' do
    it 'exibe o nome fantasia e a razão social' do
      # Arrange
      s = Supplier.new(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung')

      # Act
      
      # Assert
      expect(s.supplier_full_description).to eq 'Samsung - Samsung Eletrônicos LTDA'
    end
  end

  describe '#formatted_registration_number' do
    it 'exibe o CNPJ formatado' do
      # Arrange
      supplier = Supplier.new(registration_number: '00000000000100')

      # Act

      # Assert
      expect(supplier.formatted_registration_number).to eq '00.000.000/0001-00'
    end
  end

  describe '#formatted_address' do
    it 'exibe o endereço completo com cidade e estado' do
      # Arrange
      supplier = Supplier.new(city: 'São Paulo', state: 'SP', full_address: 'Av. Beda, 120')

      # Act

      # Assert
      expect(supplier.formatted_address).to eq 'Av. Beda, 120 - São Paulo - SP'
    end
  end

  describe '#formatted_postal_code' do
    it 'exibe o endereço completo com cidade e estado' do
      # Arrange
      supplier = Supplier.new(postal_code: '00000-000')

      # Act

      # Assert
      expect(supplier.formatted_postal_code).to eq '00.000-000'
    end
  end
end

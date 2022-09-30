require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'corporate_name is mandatory' do
        # Arrange
        supplier = Supplier.new(corporate_name: '')
        
        # Act
        supplier.valid?

        # Assert
        expect(supplier.errors.include? :corporate_name).to be true
      end

      it 'brand_name is mandatory' do
        # Arrange
        supplier = Supplier.new(brand_name: '')

        # Act
        supplier.valid?

        # Assert
        expect(supplier.errors.include? :brand_name).to be true
      end

      it 'registration_number is mandatory' do
        # Arrange
        supplier = Supplier.new(registration_number: '')

        # Act
        supplier.valid?

        # Assert
        expect(supplier.errors.include? :registration_number).to be true
      end

      it 'email is mandatory' do
        # Arrange
        supplier = Supplier.new(email: '')

        # Act
        supplier.valid?

        # Assert
        expect(supplier.errors.include? :email).to be true
      end
    end

    context 'uniqueness' do
      # Arrange
      it 'registration_number must be unique' do
        first_supplier = Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '00000000000100', 
                                          full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', postal_code: '12240-670', 
                                          email: 'contato@acme.com.br', phone_number: '22999994444')
        second_supplier = Supplier.new(registration_number: '00000000000100')
      
        # Act
        second_supplier.valid?

        # Assert
        expect(second_supplier.errors.include? :registration_number).to be true
      end
    end

    context 'length' do
      it 'registration_number must be 14 characters long' do
        # Arrange
        supplier = Supplier.new(registration_number: '12345678912345')
      
        # Act
        supplier.valid?

        # Assert
        expect(supplier.errors.include? :registration_number).to be false
      end

      it 'registration_number must not be long' do
        # Arrange
        supplier = Supplier.new(registration_number: '123456789123456')
      
        # Act
        supplier.valid?

        # Assert
        expect(supplier.errors.include? :registration_number).to be true
      end

      it 'registration_number must not be short' do
        # Arrange
        supplier = Supplier.new(registration_number: '1234567891234')
      
        # Act
        supplier.valid?

        # Assert
        expect(supplier.errors.include? :registration_number).to be true
      end
    end

    context 'format' do
      it 'postal code must be 5 numbers, 1 - and 3 numbers' do
        # Arrange
        supplier = Supplier.new(postal_code: '12240-670')

        # Act
        supplier.valid?

        # Assert
        expect(supplier.errors.include? :postal_code).to be false
      end

      it 'postal code must not be short' do
        # Arrange
        supplier = Supplier.new(postal_code: '12240-67')

        # Act
        supplier.valid?

        # Assert
        expect(supplier.errors.include? :postal_code).to be true
      end

      it 'postal code must not be long' do
        # Arrange
        supplier = Supplier.new(postal_code: '12240-6700')

        # Act
        supplier.valid?

        # Assert
        expect(supplier.errors.include? :postal_code).to be true
      end

      it 'postal code must have -' do
        # Arrange
        supplier = Supplier.new(postal_code: '12240670')

        # Act
        supplier.valid?

        # Assert
        expect(supplier.errors.include? :postal_code).to be true
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

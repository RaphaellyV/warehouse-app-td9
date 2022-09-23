require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'name is mandatory' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                    full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                    email: 'contato@samsung.com.br', phone_number: '22998888888')
        pm = ProductModel.new(name: '', weight: 8_000, width: 70, height: 45, depth: 10, 
                              sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

        # Act

        # Assert
        expect(pm.valid?).to eq false
      end

      it 'weight is mandatory' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                    full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                    email: 'contato@samsung.com.br', phone_number: '22998888888')
        pm = ProductModel.new(name: 'TV-32', weight: '', width: 70, height: 45, depth: 10, 
                              sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

        # Act

        # Assert
        expect(pm.valid?).to eq false
      end

      it 'width is mandatory' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                    full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                    email: 'contato@samsung.com.br', phone_number: '22998888888')
        pm = ProductModel.new(name: 'TV-32', weight: 8_000, width: '', height: 45, depth: 10, 
                              sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

        # Act

        # Assert
        expect(pm.valid?).to eq false
      end

      it 'height is mandatory' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                    full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                    email: 'contato@samsung.com.br', phone_number: '22998888888')
        pm = ProductModel.new(name: 'TV-32', weight: 8_000, width: 70, height: '', depth: 10, 
                              sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

        # Act

        # Assert
        expect(pm.valid?).to eq false
      end

      it 'depth is mandatory' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                    full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                    email: 'contato@samsung.com.br', phone_number: '22998888888')
        pm = ProductModel.new(name: 'TV-32', weight: 8_000, width: 70, height: 45, depth: '', 
                              sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

        # Act

        # Assert
        expect(pm.valid?).to eq false
      end

      it 'sku is mandatory' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                    full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                    email: 'contato@samsung.com.br', phone_number: '22998888888')
        pm = ProductModel.new(name: 'TV-32', weight: 8_000, width: 70, height: 45, depth: 10, 
                              sku: '', supplier: supplier)

        # Act

        # Assert
        expect(pm.valid?).to eq false
      end
    end

    context 'length' do
      it 'false when SKU is short' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                    full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                    email: 'contato@samsung.com.br', phone_number: '22998888888')
        pm = ProductModel.new(name: 'TV-32', weight: 8_000, width: 70, height: 45, depth: 10, 
                              sku: 'TV32P-SAMSUNG-XPTO9', supplier: supplier)

        # Act

        # Assert
        expect(pm.valid?).to eq false
      end
      it 'false when SKU is long' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                    full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                    email: 'contato@samsung.com.br', phone_number: '22998888888')
        pm = ProductModel.new(name: 'TV-32', weight: 8_000, width: 70, height: 45, depth: 10, 
                              sku: 'TV32P-SAMSUNG-XPTO900', supplier: supplier)

        # Act

        # Assert
        expect(pm.valid?).to eq false
      end
    end

    context 'uniqueness' do
      it 'SKU must be unique' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                    full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                    email: 'contato@samsung.com.br', phone_number: '22998888888')

        pm = ProductModel.create!(name: 'TV-32', weight: 8_000, width: 70, height: 45, depth: 10, 
                              sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)
        other_pm = ProductModel.new(name: 'TV-32G', weight: 7_000, width: 75, height: 50, depth: 12, 
                                    sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

        # Act

        # Assert
        expect(other_pm.valid?).to eq false
      end
    end

    context 'numericality' do
      it 'weight must be greater than zero' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                    full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                    email: 'contato@samsung.com.br', phone_number: '22998888888')

        pm = ProductModel.new(name: 'TV-32', weight: -1, width: 70, height: 45, depth: 10, 
                                  sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

        # Act

        # Assert
        expect(pm.valid?).to eq false
      end

      it 'weight must not be equal to zero' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                    full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                    email: 'contato@samsung.com.br', phone_number: '22998888888')

        pm = ProductModel.new(name: 'TV-32', weight: 0, width: 70, height: 45, depth: 10, 
                                  sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

        # Act

        # Assert
        expect(pm.valid?).to eq false
      end

      it 'width must be greater than zero' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                    full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                    email: 'contato@samsung.com.br', phone_number: '22998888888')

        pm = ProductModel.new(name: 'TV-32', weight: 8_000, width: -1, height: 45, depth: 10, 
                                  sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

        # Act

        # Assert
        expect(pm.valid?).to eq false
      end

      it 'width must not be equal to zero' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                    full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                    email: 'contato@samsung.com.br', phone_number: '22998888888')

        pm = ProductModel.new(name: 'TV-32', weight: 8_000, width: 0, height: 45, depth: 10, 
                                  sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

        # Act

        # Assert
        expect(pm.valid?).to eq false
      end

      it 'height must be greater than zero' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                    full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                    email: 'contato@samsung.com.br', phone_number: '22998888888')

        pm = ProductModel.new(name: 'TV-32', weight: 8_000, width: 70, height: -1, depth: 10, 
                                  sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

        # Act

        # Assert
        expect(pm.valid?).to eq false
      end

      it 'height must not be equal to zero' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                    full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                    email: 'contato@samsung.com.br', phone_number: '22998888888')

        pm = ProductModel.new(name: 'TV-32', weight: 8_000, width: 70, height: 0, depth: 10, 
                                  sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

        # Act

        # Assert
        expect(pm.valid?).to eq false
      end

      it 'depth must be greater than zero' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                    full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                    email: 'contato@samsung.com.br', phone_number: '22998888888')

        pm = ProductModel.new(name: 'TV-32', weight: 8_000, width: 70, height: 45, depth: -1, 
                                  sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

        # Act

        # Assert
        expect(pm.valid?).to eq false
      end

      it 'depth must not be equal to zero' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                                    full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                                    email: 'contato@samsung.com.br', phone_number: '22998888888')

        pm = ProductModel.new(name: 'TV-32', weight: 8_000, width: 70, height: 45, depth: 0, 
                                  sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)

        # Act

        # Assert
        expect(pm.valid?).to eq false
      end
    end
  end
end

require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'name is mandatory' do
        # Arrange
        pm = ProductModel.new(name: '')

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :name).to be true
      end

      it 'weight is mandatory' do
        # Arrange
        pm = ProductModel.new(weight: '')

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :weight).to be true
      end

      it 'width is mandatory' do
        # Arrange
        pm = ProductModel.new(width: '')

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :width).to eq true
      end

      it 'height is mandatory' do
        # Arrange
        pm = ProductModel.new(height: '')

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :height).to be true
      end

      it 'depth is mandatory' do
        # Arrange
        pm = ProductModel.new(depth: '')

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :depth).to be true
      end

      it 'sku is mandatory' do
        # Arrange
        pm = ProductModel.new(sku: '')

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :sku).to be true
      end
    end

    context 'length' do
      it 'SKU must be 20 characters long' do
        # Arrange
        pm = ProductModel.new(sku: 'TV32P-SAMSUNG-XPTO90')

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :sku).to be false
      end

      it 'SKU must not be short' do
        # Arrange
        pm = ProductModel.new(sku: 'TV32P-SAMSUNG-XPTO9')

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :sku).to be true
      end

      it 'SKU must not be long' do
        # Arrange
        pm = ProductModel.new(sku: 'TV32P-SAMSUNG-XPTO900')

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :sku).to be true
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

        other_pm = ProductModel.new(sku: 'TV32P-SAMSUNG-XPTO90')

        # Act
        other_pm.valid?

        # Assert
        expect(other_pm.errors.include? :sku).to be true
      end
    end

    context 'numericality' do
      it 'weight must be greater than zero' do
        # Arrange
        pm = ProductModel.new(weight: 1)

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :weight).to be false
      end

      it 'weight must not be less than zero' do
        # Arrange
        pm = ProductModel.new(weight: -1)

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :weight).to be true
      end

      it 'weight must not be equal to zero' do
        # Arrange
        pm = ProductModel.new(weight: 0)

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :weight).to be true
      end

      it 'width must be greater than zero' do
        # Arrange
        pm = ProductModel.new(width: 1)

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :width).to be false
      end

      it 'width must not be less than zero' do
        # Arrange
        pm = ProductModel.new(width: -1)

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :width).to be true
      end

      it 'width must not be equal to zero' do
        # Arrange
        pm = ProductModel.new(width: 0)

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :width).to be true
      end

      it 'height must be greater than zero' do
        # Arrange
        pm = ProductModel.new(height: 1)

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :height).to be false
      end

      it 'height must not be less than zero' do
        # Arrange
        pm = ProductModel.new(height: -1)

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :height).to be true
      end

      it 'height must not be equal to zero' do
        # Arrange
        pm = ProductModel.new(height: 0)

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :height).to be true
      end

      it 'depth must be greater than zero' do
        # Arrange
        pm = ProductModel.new(depth: 1)

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :depth).to be false
      end

      it 'depth must not be less than zero' do
        # Arrange
        pm = ProductModel.new(depth: -1)

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :depth).to be true
      end

      it 'depth must not be equal to zero' do
        # Arrange
        pm = ProductModel.new(depth: 0)

        # Act
        pm.valid?

        # Assert
        expect(pm.errors.include? :depth).to be true
      end
    end
  end

  describe '#dimensions' do
    it 'exibe o comprimento, a largura e a altura' do
      # Arrange
      pm = ProductModel.new(width: 40, depth: 30, height: 60)

      # Act

      # Assert
      expect(pm.dimensions).to eq '40 cm x 30 cm x 60 cm'
    end
  end
end

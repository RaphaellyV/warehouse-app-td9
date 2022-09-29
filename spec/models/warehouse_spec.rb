require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'name is mandatory' do
        # Arrange
        warehouse = Warehouse.new(name: '', code: 'RIO', address: 'Endereço',
                                  city: 'Rio', postal_code: '25000-000', area: 1000,
                                  description: 'Alguma descrição.', state: 'RJ')
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end
  
      it 'code is mandatory' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: '', address: 'Endereço',
                                  city: 'Rio', postal_code: '25000-000', area: 1000,
                                  description: 'Alguma descrição.', state: 'RJ')
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end
  
      it 'address is mandatory' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: '',
                                  city: 'Rio', postal_code: '25000-000', area: 1000,
                                  description: 'Alguma descrição.', state: 'RJ')
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end
  
      it 'city is mandatory' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  city: '', postal_code: '25000-000', area: 1000,
                                  description: 'Alguma descrição.', state: 'RJ')
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end

      it 'state is mandatory' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  city: 'Rio de Janeiro', postal_code: '25000-000', area: 1000,
                                  description: 'Alguma descrição.', state: '')
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end
  
      it 'postal code is mandatory' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  city: 'Rio de Janeiro', postal_code: '', area: 1000,
                                  description: 'Alguma descrição.', state: 'RJ')
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end
  
      it 'area is mandatory' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  city: 'Rio de Janeiro', postal_code: '25000-000', area: '',
                                  description: 'Alguma descrição.', state: 'RJ')
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end
  
      it 'description is mandatory' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  city: 'Rio de Janeiro', postal_code: '25000-000', area: 1000,
                                  description: '', state: 'RJ')
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end
    end
    
    context 'uniqueness' do
      it 'code must be unique' do
        # Arrange
        first_warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço',
                                            city: 'Rio', postal_code: '25000-000', area: 1000,
                                            description: 'Alguma descrição.', state: 'RJ')
        second_warehouse = Warehouse.new(name: 'Niterói', code: 'RIO', address: 'Avenida',
                                         city: 'Niterói', postal_code: '26000-000', area: 1500,
                                         description: 'Outra descrição.', state: 'Rio de Janeiro')
        
        # Act
        result = second_warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end
  
      it 'name must be unique' do
        # Arrange
        first_warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço',
                                            city: 'Rio', postal_code: '25000-000', area: 1000,
                                            description: 'Alguma descrição.', state: 'RJ')
      
        second_warehouse = Warehouse.new(name: 'Rio', code: 'NIT', address: 'Avenida',
                                         city: 'Niterói', postal_code: '26000-000', area: 1500,
                                         description: 'Outra descrição.', state: 'Rio de Janeiro')

      
        # Act
        result = second_warehouse.valid?

        # Assert
        expect(result).to eq false
      end
    end

    context 'format' do
      it 'false when postal code is short' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  city: 'Rio de Janeiro', postal_code: '25000-00', area: 1000,
                                  description: 'Alguma descrição.', state: 'RJ')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when postal code is long' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  city: 'Rio de Janeiro', postal_code: '25000-0000', area: 1000,
                                  description: 'Alguma descrição.', state: 'RJ')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when postal code has no -' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  city: 'Rio de Janeiro', postal_code: '25000000', area: 1000,
                                  description: 'Alguma descrição.', state: 'RJ')

        # Act
        result = warehouse.valid?

        # Assert
        expect(result).to eq false
      end
    end
  end

  describe '#warehouse_full_description' do
    it 'exibe o código e nome do galpão' do
      # Arrange
      w = Warehouse.new(name: 'Galpão Cuiabá', code: 'CBA')

      # Act
      result = w.warehouse_full_description
      
      # Assert
      expect(result).to eq 'CBA - Galpão Cuiabá'
    end
  end

  describe '#formatted_address' do
    it 'exibe o endereço, a cidade e o estado do galpão' do
      # Arrange
      w = Warehouse.new(city: 'São Paulo', state: 'SP', address: 'Av. Beda, 120')

      # Act
      
      # Assert
      expect(w.formatted_address).to eq 'Av. Beda, 120 - São Paulo/SP'
    end
  end
end

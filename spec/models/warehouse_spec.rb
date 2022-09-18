require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        # Arrange
        warehouse = Warehouse.new(name: '', code: 'RIO', address: 'Endereço',
                                  city: 'Rio', postal_code: '25000-000', area: 1000,
                                  description: 'Alguma descrição.', state: 'RJ')
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end
  
      it 'false when code is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: '', address: 'Endereço',
                                  city: 'Rio', postal_code: '25000-000', area: 1000,
                                  description: 'Alguma descrição.', state: 'RJ')
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end
  
      it 'false when address is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: '',
                                  city: 'Rio', postal_code: '25000-000', area: 1000,
                                  description: 'Alguma descrição.', state: 'RJ')
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end
  
      it 'false when city is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  city: '', postal_code: '25000-000', area: 1000,
                                  description: 'Alguma descrição.', state: 'RJ')
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end

      it 'false when state is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  city: 'Rio de Janeiro', postal_code: '25000-000', area: 1000,
                                  description: 'Alguma descrição.', state: '')
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end
  
      it 'false when postal code is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  city: 'Rio de Janeiro', postal_code: '', area: 1000,
                                  description: 'Alguma descrição.', state: 'RJ')
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end
  
      it 'false when area is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço',
                                  city: 'Rio de Janeiro', postal_code: '25000-000', area: '',
                                  description: 'Alguma descrição.', state: 'RJ')
        # Act
        result = warehouse.valid?
  
        # Assert
        expect(result).to eq false
      end
  
      it 'false when description is empty' do
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
      it 'false when code is already in use' do
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
  
      it 'false when name is already in use' do
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
end

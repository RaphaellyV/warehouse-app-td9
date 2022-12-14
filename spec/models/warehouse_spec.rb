require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'name is mandatory' do
        # Arrange
        warehouse = Warehouse.new(name: '')
        # Act
        warehouse.valid?
  
        # Assert
        expect(warehouse.errors.include? :name).to be true
      end
  
      it 'code is mandatory' do
        # Arrange
        warehouse = Warehouse.new(code: '')

        # Act
        warehouse.valid?
  
        # Assert
        expect(warehouse.errors.include? :code).to be true
      end
  
      it 'address is mandatory' do
        # Arrange
        warehouse = Warehouse.new(address: '')
       
        # Act
        warehouse.valid?
  
        # Assert
        expect(warehouse.errors.include? :address).to be true
      end
  
      it 'city is mandatory' do
        # Arrange
        warehouse = Warehouse.new(city: '')

        # Act
        warehouse.valid?
  
        # Assert
        expect(warehouse.errors.include? :city).to be true
      end

      it 'state is mandatory' do
        # Arrange
        warehouse = Warehouse.new(state: '')
        
        # Act
        warehouse.valid?
  
        # Assert
        expect(warehouse.errors.include? :state).to be true
      end
  
      it 'postal code is mandatory' do
        # Arrange
        warehouse = Warehouse.new(postal_code: '')

        # Act
        warehouse.valid?
  
        # Assert
        expect(warehouse.errors.include? :postal_code).to be true
      end
  
      it 'area is mandatory' do
        # Arrange
        warehouse = Warehouse.new(area: '')

        # Act
        warehouse.valid?
  
        # Assert
        expect(warehouse.errors.include? :area).to be true
      end
  
      it 'description is mandatory' do
        # Arrange
        warehouse = Warehouse.new(description: '')

        # Act
        warehouse.valid?
  
        # Assert
        expect(warehouse.errors.include? :description).to be true
      end
    end
    
    context 'uniqueness' do
      it 'code must be unique' do
        # Arrange
        first_warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endere??o',
                                            city: 'Rio', postal_code: '25000-000', area: 1000,
                                            description: 'Alguma descri????o.', state: 'RJ')
        second_warehouse = Warehouse.new(code: 'RIO')
        
        # Act
        second_warehouse.valid?
  
        # Assert
        expect(second_warehouse.errors.include? :code).to be true
      end
  
      it 'name must be unique' do
        # Arrange
        first_warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endere??o',
                                            city: 'Rio', postal_code: '25000-000', area: 1000,
                                            description: 'Alguma descri????o.', state: 'RJ')
      
        second_warehouse = Warehouse.new(name: 'Rio')

      
        # Act
        second_warehouse.valid?

        # Assert
        expect(second_warehouse.errors.include? :name).to be true
      end
    end

    context 'format' do
      it 'postal code must be 5 numbers, 1 - and 3 numbers' do
        # Arrange
        warehouse = Warehouse.new(postal_code: '12240-670')

        # Act
        warehouse.valid?

        # Assert
        expect(warehouse.errors.include? :postal_code).to be false
      end

      it 'postal code must not be short' do
        # Arrange
        warehouse = Warehouse.new(postal_code: '25000-00')

        # Act
        warehouse.valid?

        # Assert
        expect(warehouse.errors.include? :postal_code).to be true
      end

      it 'postal code must not be long' do
        # Arrange
        warehouse = Warehouse.new(postal_code: '25000-0000')

        # Act
        warehouse.valid?

        # Assert
        expect(warehouse.errors.include? :postal_code).to be true
      end

      it 'postal code must have -' do
        # Arrange
        warehouse = Warehouse.new(postal_code: '25000000')

        # Act
        warehouse.valid?

        # Assert
        expect(warehouse.errors.include? :postal_code).to be true
      end
    end
  end

  describe '#warehouse_full_description' do
    it 'exibe o c??digo e nome do galp??o' do
      # Arrange
      w = Warehouse.new(name: 'Galp??o Cuiab??', code: 'CBA')

      # Act
      result = w.warehouse_full_description
      
      # Assert
      expect(result).to eq 'CBA - Galp??o Cuiab??'
    end
  end

  describe '#formatted_address' do
    it 'exibe o endere??o, a cidade e o estado do galp??o' do
      # Arrange
      w = Warehouse.new(city: 'S??o Paulo', state: 'SP', address: 'Av. Beda, 120')

      # Act
      
      # Assert
      expect(w.formatted_address).to eq 'Av. Beda, 120 - S??o Paulo/SP'
    end
  end
end

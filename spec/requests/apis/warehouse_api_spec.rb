require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses/1' do
    it 'success' do
      # Arrange
      w = Warehouse.create!(name: 'Cuiabá', code: 'CGB', city: 'Cuiabá', area: 10_000, state: 'MT',
                            description: 'Galpão no centro do país.', postal_code: '76000-000', address: 'Av. dos Jacarés, 1000')
    

      # Act
      get "/api/v1/warehouses/#{ w.id }"

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      
      json_response = JSON.parse(response.body)
      
      expect(json_response["name"]).to eq 'Cuiabá'
      expect(json_response["code"]).to eq 'CGB'
      expect(json_response.keys).not_to include("created_at")
      expect(json_response.keys).not_to include("updated_at")
    end

    it 'fail if warehouse not found' do
      # Arrange

      # Act
      get "/api/v1/warehouses/99999999999"

      # Assert
      expect(response.status).to eq 404
    end
  end

  context 'GET /api/v1/warehouses' do
    it 'lists all warehouses by name' do
      # Arrange
      Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, state: 'RJ',
                        description: 'Galpão do Rio.', postal_code: '20000-000', address: 'Av. do Porto, 1000')
      Warehouse.create!(name: 'Maceió', code: 'MCZ',  city: 'Maceió', area: 50_000, state: 'AL',
                        description: 'Galpão de Maceió.', postal_code: '80000-000', address: 'Av. Atlântica, 50')

      # Act
      get '/api/v1/warehouses'

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response.length).to eq 2
      expect(json_response.first["name"]).to eq 'Maceió'
      expect(json_response.second["name"]).to eq 'Rio'
    end

    it 'returns empty if there is no warehouse' do
      # Arrange

      # Act
      get '/api/v1/warehouses'

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
  end
end
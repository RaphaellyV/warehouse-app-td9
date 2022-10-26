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
    end
  end
end
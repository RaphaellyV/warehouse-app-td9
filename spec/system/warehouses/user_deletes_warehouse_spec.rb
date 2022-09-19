require 'rails_helper'

describe 'Usuário remove um galpão' do
  it 'com sucesso' do
    # Arrange
    w = Warehouse.create!(name: 'Cuiabá', code: 'CGB', city: 'Cuiabá', area: 10_000, state: 'MT',
                          description: 'Galpão no centro do país.', postal_code: '76000-000', address: 'Av. dos Jacarés, 1000')
    
    # Act
    visit root_path
    click_on 'Cuiabá'
    click_on 'Remover'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso.'
    expect(page).not_to have_content 'Cuiabá'
    expect(page).not_to have_content 'CGB'
  end

  it 'e não apaga outros galpões' do
    # Arrange
    first_warehouse = Warehouse.create!(name: 'Cuiabá', code: 'CGB', city: 'Cuiabá', area: 10_000, state: 'MT',
                                        description: 'Galpão no centro do país.', postal_code: '76000-000', address: 'Av. dos Jacarés, 1000')
    second_warehouse = Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', city: 'Belo Horizonte', area: 20_000, state: 'MG',
                                         description: 'Galpão para cargas mineiras.', postal_code: '46000-000', address: 'Av. Tiradentes, 20')
  
    # Act
    visit root_path
    click_on 'Cuiabá'
    click_on 'Remover'

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso.'
    expect(page).to have_content 'Belo Horizonte'
    expect(page).not_to have_content 'Cuiabá'
  end
end
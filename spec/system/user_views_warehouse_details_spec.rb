require 'rails_helper'

describe 'Usuário vê detalhes de um galpão' do
  it 'e vê informações adicionais' do
    # Arrange
    Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                     address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
                     description: 'Galpão destinado a cargas internacionais.', state: 'SP')

    # Act
    visit('/')
    click_on('Aeroporto SP')

    # Assert
    expect(page).to have_content('Galpão GRU')
    expect(page).to have_content('Nome: Aeroporto SP')
    expect(page).to have_content('Cidade: Guarulhos')
    expect(page).to have_content('Estado: SP')
    expect(page).to have_content('Área: 100.000 m²')
    expect(page).to have_content('Endereço: Avenida do Aeroporto, 1000 CEP: 15000-000')
    expect(page).to have_content('Galpão destinado a cargas internacionais.')
  end

  it 'e volta para a tela inicial' do
    # Arrange
    Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, 
                     address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
                     description: 'Galpão destinado a cargas internacionais.', state: 'SP')

    # Act
    visit '/'
    click_on 'Aeroporto SP'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eql(root_path)
  end
end 
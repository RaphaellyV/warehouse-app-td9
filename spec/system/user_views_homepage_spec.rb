require "rails_helper"

describe 'Usuário visita a tela inicial' do
  it 'e vê o nome da app' do
    # Arrange

    # Act
    visit(root_path)

    # Assert
    expect(page).to have_content('Galpões & Estoque')
  end

  it 'e vê os galpões cadastrados' do
    # Arrange
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, 
                     description: 'Galpão do Rio.', postal_code: '20000-000', address: 'Av. do Porto, 1000')
    Warehouse.create(name: 'Maceió', code: 'MCZ',  city: 'Maceió', area: 50_000, 
                     description: 'Galpão de Maceió.', postal_code: '80000-000', address: 'Av. Atlântica, 50')

    # Act
    visit(root_path)

    # Assert
    expect(page).not_to have_content('Não existem galpões cadastrados.')

    expect(page).to have_content('Rio')
    expect(page).to have_content('Código: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('60.000 m²')

    expect(page).to have_content('Maceió')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Cidade: Maceió')
    expect(page).to have_content('50.000 m²')
  end

  it 'e não existem galpões cadastrados' do
    # Arrange
    
    # Act
    visit(root_path)

    # Assert
    expect(page).to have_content('Não existem galpões cadastrados.')
  end
end
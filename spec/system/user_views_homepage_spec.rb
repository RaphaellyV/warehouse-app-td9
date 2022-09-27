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
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, state: 'RJ',
                      description: 'Galpão do Rio.', postal_code: '20000-000', address: 'Av. do Porto, 1000')
    Warehouse.create!(name: 'Maceió', code: 'MCZ',  city: 'Maceió', area: 50_000, state: 'AL',
                      description: 'Galpão de Maceió.', postal_code: '80000-000', address: 'Av. Atlântica, 50')

    # Act
    login_as user
    visit(root_path)

    # Assert
    expect(page).not_to have_content('Não existem galpões cadastrados.')

    expect(page).to have_content('Rio')
    expect(page).to have_content('Código: SDU')
    expect(page).to have_content('Local: Rio de Janeiro/RJ')
    expect(page).to have_content('Área: 60.000 m²')

    expect(page).to have_content('Maceió')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Local: Maceió/AL')
    expect(page).to have_content('Área: 50.000 m²')
  end

  it 'e não existem galpões cadastrados' do
    # Arrange
    user = User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

    # Act
    login_as user
    visit(root_path)

    # Assert
    expect(page).to have_content('Não existem galpões cadastrados.')
  end
end
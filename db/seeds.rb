# Galpões Exemplo
Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, state: 'RJ',
                  description: 'Galpão do Rio.', postal_code: '20000-000', address: 'Av. do Porto, 1000')
Warehouse.create!(name: 'Maceió', code: 'MCZ',  city: 'Maceió', area: 50_000, state: 'AL',
                  description: 'Galpão de Maceió.', postal_code: '80000-000', address: 'Av. Atlântica, 50')

# Fornecedores Exemplo
Supplier.create!(corporate_name: 'ACME LTDA', brand_name: 'ACME', registration_number: '00000000000100', 
                 full_address: 'Av. das Palmas, 100', city: 'Bauru', state: 'SP', postal_code: '12240-670', 
                 email: 'contato@acme.com.br', phone_number: '22999994444')
supplier = Supplier.create!(corporate_name: 'Samsung Eletrônicos LTDA', brand_name: 'Samsung', registration_number: '12300000000100', 
                            full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', postal_code: '12240-670', 
                            email: 'contato@samsung.com.br', phone_number: '22998888888')
 other_supplier = Supplier.create!(corporate_name: 'Stark Industries LTDA', brand_name: 'Stark', registration_number: '11000000000100', 
                             full_address: 'Torre da Indústria, 1', city: 'Teresina', state: 'PI', postal_code: '64000-020',
                             email: 'contato@stark.com', phone_number: '22999994445')

# Produtos Exemplo
ProductModel.create!(name: 'TV 32', weight: 8_000, width: 70, height: 45, depth: 10, 
                     sku: 'TV32P-SAMSUNG-XPTO90', supplier: supplier)
ProductModel.create!(name:'Soundbar 7.1 Surround', weight: 3_000, width: 80, height: 15, 
                     depth: 10, sku: 'SOU71PP-STARK-NOIZ77', supplier: other_supplier)

# Usuários Exemplo
User.create!(name: 'Pessoa', email: 'pessoa@email.com', password: 'password')

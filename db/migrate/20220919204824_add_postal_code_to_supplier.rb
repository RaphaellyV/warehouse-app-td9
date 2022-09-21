class AddPostalCodeToSupplier < ActiveRecord::Migration[7.0]
  def change
    add_column :suppliers, :postal_code, :string
  end
end

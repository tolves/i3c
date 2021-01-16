class AddColumnsToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :band, :string
    add_column :products, :price, :integer
  end
end

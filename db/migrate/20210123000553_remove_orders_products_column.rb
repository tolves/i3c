class RemoveOrdersProductsColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :products
  end
end

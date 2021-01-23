class AddPriceToLists < ActiveRecord::Migration[6.1]
  def change
    add_column :lists, :price, :integer, default: 0
  end
end

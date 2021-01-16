class AddMetadatetoProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :meta_data, :text
  end
end

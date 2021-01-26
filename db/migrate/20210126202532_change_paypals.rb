class ChangePaypals < ActiveRecord::Migration[6.1]
  def change
    rename_column :paypals, :p_orderId, :orderID
    rename_column :paypals, :p_data, :data
    rename_column :paypals, :p_details, :response
  end
end

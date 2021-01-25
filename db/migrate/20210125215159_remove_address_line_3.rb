class RemoveAddressLine3 < ActiveRecord::Migration[6.1]
  def change
    remove_column :addresses, :line_3
  end
end

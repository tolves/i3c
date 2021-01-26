class AddColumnPaypals < ActiveRecord::Migration[6.1]
  def change
    add_column :paypals, :payer, :text
    add_column :paypals, :items, :text
  end
end

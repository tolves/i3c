class CreatePaypals < ActiveRecord::Migration[6.1]
  def change
    create_table :paypals do |t|
      t.belongs_to :order
      t.string :p_orderId
      t.text :p_data
      t.text :p_details
      t.timestamps
    end
  end
end

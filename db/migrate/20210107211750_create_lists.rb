class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.belongs_to :cart
      t.belongs_to :product
      t.integer :quantity
      t.timestamps
    end
  end
end

class CreateInbounds < ActiveRecord::Migration[6.1]
  def change
    create_table :inbounds do |t|
      t.belongs_to :product
      t.integer :quantity, default: 0
      t.text :note
      t.integer :cost, default: 0
      t.timestamps
    end
  end
end

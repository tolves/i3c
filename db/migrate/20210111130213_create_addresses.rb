class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.belongs_to :user
      t.string :country
      t.string :full_name
      t.string :phone
      t.string :postcode
      t.string :line_1
      t.string :line_2
      t.string :line_3
      t.string :town
      t.string :county
      t.text :instructions
      t.string :security_code
      t.timestamps
    end
  end
end

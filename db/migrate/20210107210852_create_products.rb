class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.belongs_to :category
      t.string :title
      t.text :description
      t.timestamps
    end
  end
end

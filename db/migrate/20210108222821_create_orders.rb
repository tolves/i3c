class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :orders, id: :uuid do |t|
      # TODO migrate order
      t.belongs_to :address
      t.belongs_to :user
      t.integer :products, array: true
      t.string :status
      t.timestamps
    end
    add_index :orders, :products, using: 'gin'
  end
end

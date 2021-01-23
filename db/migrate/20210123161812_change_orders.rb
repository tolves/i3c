class ChangeOrders < ActiveRecord::Migration[6.1]
  def change
    drop_table :orders

    create_table :orders do |t|
      t.belongs_to :user
      t.string :status
      t.timestamps
    end
  end
end

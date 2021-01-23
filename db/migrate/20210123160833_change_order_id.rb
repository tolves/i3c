class ChangeOrderId < ActiveRecord::Migration[6.1]
  def change
    drop_table :orders

    create_table :orders, id: :uuid do |t|
      t.belongs_to :user
      t.string :status
      t.timestamps
    end
  end
end

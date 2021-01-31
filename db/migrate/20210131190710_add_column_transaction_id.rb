class AddColumnTransactionId < ActiveRecord::Migration[6.1]
  def change
    add_column :paypals, :transaction_id, :string
  end
end

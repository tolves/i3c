class AddCountableToCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :countable, :boolean, default: false
  end
end

class AddListabletoList < ActiveRecord::Migration[6.1]
  def change
    remove_belongs_to :lists, :cart
    add_reference :lists, :listable, polymorphic: true, index: true
  end
end

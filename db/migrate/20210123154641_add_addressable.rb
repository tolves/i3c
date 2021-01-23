class AddAddressable < ActiveRecord::Migration[6.1]
  def change
    remove_belongs_to :addresses, :user
    add_reference :addresses, :addressable, polymorphic: true, index: true
  end
end
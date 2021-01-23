class Cart < ApplicationRecord
  has_many :lists, dependent: :destroy, :as => :listable
  has_many :products, through: :lists

  def amount
    self.lists.sum { |v| v.price }
  end
end

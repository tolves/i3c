class Cart < ApplicationRecord
  has_many :lists
  has_many :products, through: :lists
end

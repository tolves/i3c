class Cart < ApplicationRecord
  has_many :lists, dependent: :destroy
  has_many :products, through: :lists
end

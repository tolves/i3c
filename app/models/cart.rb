class Cart < ApplicationRecord
  has_many :lists, dependent: :destroy, :as => :listable
  has_many :products, through: :lists
end

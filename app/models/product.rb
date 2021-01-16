class Product < ApplicationRecord
  has_many :lists
  belongs_to :category
  serialize :meta_data, Hash

end

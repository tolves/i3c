class Product < ApplicationRecord
  has_many :lists, dependent: :destroy
  belongs_to :category
  has_one :inbound
  serialize :meta_data, Hash
  has_rich_text :content
end

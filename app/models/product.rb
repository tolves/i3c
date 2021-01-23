class Product < ApplicationRecord
  has_many :lists, dependent: :destroy
  belongs_to :category
  has_one :inbound
  serialize :meta_data, Hash
  has_rich_text :content

  validates :title, presence: true
  validates :band, presence: true
  validates :price, presence: true
  validates :description, presence: true
end

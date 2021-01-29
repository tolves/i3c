class Product < ApplicationRecord
  has_many :lists, dependent: :destroy
  belongs_to :category
  has_one :inventory, autosave: true, validate: true, dependent: :destroy
  has_one_attached :image
  serialize :meta_data, Hash
  has_rich_text :content

  validates :title, presence: true, uniqueness: true
  validates :band, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :image, presence: true
  scope :in_stock, -> { joins(:inventory).merge(Inventory.in_stock) }

  def in_stock?
    return false if !self.inventory
    return false if self.inventory == 0
    true
  end
end
class Inbound < ApplicationRecord
  belongs_to :product, touch: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :cost, presence: true
  scope :in_stock, -> { where('quantity > ?', 0) }

  def quantity=(quantity)
    quantity = self.quantity + quantity.to_i
    super(quantity)
  end
end
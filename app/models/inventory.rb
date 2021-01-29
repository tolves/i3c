class Inventory < ApplicationRecord
  belongs_to :product, touch: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :cost, presence: true
  scope :in_stock, -> { where('quantity > ?', 0) }

  def inbound(params)
    self.update!(quantity: self.quantity + params[:quantity].to_i, cost: params[:cost], note: params[:note])
  end

  def outbound(quantity)
    self.quantity -= quantity
    self.save!
  end

end

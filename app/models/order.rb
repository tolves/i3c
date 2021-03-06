class Order < ApplicationRecord
  belongs_to :user
  has_one :address, dependent: :destroy, :as => :addressable
  has_one :paypal
  has_many :lists, dependent: :destroy, :as => :listable
  has_many :products, through: :lists

  enumeration :status
  enumeration :couriers
  validates :status, presence: true

  def tracking_info
    tracking? ? 'Tracking info' : 'Add tracking information'
  end

end

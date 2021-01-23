class Order < ApplicationRecord
  belongs_to :user
  has_one :address, dependent: :destroy, :as => :addressable
  has_many :lists, dependent: :destroy, :as => :listable
  has_many :products, through: :lists

  enumeration :status
  validates :status, presence: true

end

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address

  enumeration :status
  validates :status, presence: true

end

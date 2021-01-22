class Address < ApplicationRecord
  belongs_to :user
  validates :full_name, presence: true
  validates :phone, presence: true
  validates :postcode, presence: true
  validates :line_1, presence: true
  validates :town, presence: true
  validates :county, presence: true
end

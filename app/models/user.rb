class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :recoverable #, :rememberable, :validatable
  has_one :cart, dependent: :destroy
  has_one :address, dependent: :destroy, :as => :addressable
  has_many :orders

  def admin?
    false
  end
end

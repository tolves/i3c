class Category < ApplicationRecord
  has_many :products
  serialize :meta_data, Array

  def meta_data=(meta_data)
    meta_data = meta_data.split(' ') if meta_data.is_a?(String)
    super(meta_data)
  end
end

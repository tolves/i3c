class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  serialize :meta_data, Array
  default_scope { order(id: :asc) }

  def meta_data=(meta_data)
    meta_data = meta_data.split(' ') if meta_data.is_a?(String)
    super(meta_data)
  end
end
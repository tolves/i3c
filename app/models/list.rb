class List < ApplicationRecord
  belongs_to :listable, :polymorphic => true
  belongs_to :product
end

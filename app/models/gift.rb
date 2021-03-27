class Gift < ApplicationRecord
  has_many :items, as: :cartable, dependent: :destroy
  has_many :carts, through: :items
end

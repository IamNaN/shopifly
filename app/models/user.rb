class User < ApplicationRecord
  include Carts

  has_many :carts, dependent: :destroy
  has_many :items, through: :carts
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments
end

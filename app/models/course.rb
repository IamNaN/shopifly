class Course < ApplicationRecord
  has_many :enrollments, counter_cache: true, dependent: :destroy
  has_many :items, as: :cartable, dependent: :destroy
  has_many :carts, through: :items

  def available
    quantity - enrollments.count
  end

  def available?
    available.to_i > 0
  end  
end

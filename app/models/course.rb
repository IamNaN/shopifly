class Course < ApplicationRecord
  include Cartable

  has_many :enrollments, counter_cache: true, dependent: :destroy

  def available
    quantity - enrollments.count
  end

  def available?
    available.to_i > 0
  end  
end

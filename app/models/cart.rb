class Cart < ApplicationRecord
  enum status: [:active, :pending, :archived]
  has_many :items
  # has_many :cartables, through: :items, source: :cartable

  def add(item)
    item.available? ? items.create(cartable: item) : false
  end
  
  def release
    count = items.count
    items.where('updated_at < ?', max_age.minutes.ago).destroy_all
    items.each{ |item| item.destroy unless item.cartable.available? }
    count == items.size
  end

  private
  
  def max_age
    ENV['CART_MAX_MINUTES']&.to_i || (24 * 60)
  end
end

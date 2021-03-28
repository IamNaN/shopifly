class Cart < ApplicationRecord
  enum status: [:checkout, :open, :archived]
  has_many :items
  # has_many :cartables, through: :items, source: :cartable

  def add(item)
    item.available? ? items.create(cartable: item) : false
    release
  end
  
  def release
    removed = removable.collect(&:cartable)
    removable.map(&:destroy)
    removed
  end

  # private

  def lock(enter = true)
    release
    enter ? checkout! : open!
  end

  def unlock
    lock(false)
  end

  def stale
    items.where('updated_at < ?', max_age.minutes.ago).to_a
  end

  def unavailable
    items.select{ |item| item.cartable.available - item.reserved < 1 }
  end

  def removable
    @removable ||= stale + unavailable
  end
  
  def max_age
    ENV['CART_MAX_MINUTES']&.to_i || (24 * 60)
  end
end

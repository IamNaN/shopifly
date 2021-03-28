class Item < ApplicationRecord
  belongs_to :cart
  belongs_to :cartable, polymorphic: true

  def reserved
    Item.where(cartable: cartable).includes(:cart).where(cart: { status: :checkout }).count
  end
end

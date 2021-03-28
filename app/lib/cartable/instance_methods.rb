module Cartable
  module InstanceMethods
    def reserved
      Item.where(cartable: self).includes(:cart).where(cart: { status: :checkout }).count
    end
  end
end

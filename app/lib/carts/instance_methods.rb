module Carts
  module InstanceMethods
    def cart
      @cart ||= carts.checkout.take || carts.open.take || carts.create
    end
  end
end

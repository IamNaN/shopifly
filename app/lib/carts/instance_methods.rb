module Carts
  module InstanceMethods
    def cart
      @cart ||= carts.active.take || self.carts.create
      @cart.release
      @cart
    end
  end
end
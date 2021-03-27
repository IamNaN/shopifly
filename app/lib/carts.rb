module Carts
  include ClassMethods
  include InstanceMethods

  def self.included base
    base.send :extend, ClassMethods
    base.send :include, InstanceMethods
    base.class_eval do
      has_many :carts
    end
  end
end

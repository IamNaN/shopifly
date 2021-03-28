module Cartable
  include ClassMethods
  include InstanceMethods

  def self.included base
    base.send :extend, ClassMethods
    base.send :include, InstanceMethods
    base.class_eval do
      has_many :items, as: :cartable, dependent: :destroy
      has_many :carts, through: :items
    end
  end
end

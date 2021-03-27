FactoryBot.define do
  factory :item do
    cart
    cartable { create :course }
  end
end
require 'rails_helper'

describe Cart do
  it 'accepts items' do
    user = create :user
    course = create :course

    user.cart.add course

    expect(user.cart.items.collect(&:cartable)).to include course
  end

  it 'does not accept unavailable items' do
    user = create :user
    course = create :course, quantity: 1
    create :enrollment, course: course

    user.cart.add course

    expect(user.cart.items).to_not include course
  end

  it 'releases items after a while of inactivity' do
    user = create :user
    course = create :course
    item = create :item, cart: user.cart, cartable: course, updated_at: 2.days.ago

    user.cart.release

    expect(user.cart.items).to_not include course
  end

  describe 'when an item becomes unavailable' do
    it 'release returns false' do
      user = create :user
      course = create :course, quantity: 2
      item = create :item, cart: user.cart, cartable: course
      create :enrollment, course: course
      create :enrollment, course: course
  
      expect(user.cart.release).to eq false
    end

    it 'removes the item' do
      user = create :user
      course = create :course, quantity: 2
      item = create :item, cart: user.cart, cartable: course
      create :enrollment, course: course
      create :enrollment, course: course
  
      user.cart.release
      user.cart.reload
  
      expect(user.cart.items).to_not include course
    end

    it 'notifies the user'
  end

  describe 'when entering checkout' do
    it 'reserves the items'
    it 'releases items if the user leaves checkout'
    it 'releases items after a while'
  end

  describe 'transaction has completed' do
    it 'emails a receipt'
  end
end

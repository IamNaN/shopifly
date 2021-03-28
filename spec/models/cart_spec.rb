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
    it 'release returns the items removed' do
      user = create :user
      course = create :course, quantity: 2
      item = create :item, cart: user.cart, cartable: course
      create :enrollment, course: course
      create :enrollment, course: course
  
      expect(user.cart.release).to include course
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
  end

  describe 'availablity' do
    it 'is checked when adding items' do
      user = create :user
      course = create :course, quantity: 2

      expect(user.cart).to receive(:release)
      user.cart.add course
    end

    it 'is checked when entering checkout mode' do
      user = create :user
      course = create :course, quantity: 2

      expect(user.cart).to receive(:release)
      user.cart.lock
    end

    it 'is checked when leaving checkout mode' do
      user = create :user
      course = create :course, quantity: 2

      expect(user.cart).to receive(:release)
      user.cart.unlock
    end
  end

  describe 'when entering checkout' do
    it 'reserves the items' do
      user = create :user
      course = create :course, quantity: 1
      user.cart.add course

      user.cart.lock

      expect(course.reserved).to eq 1
    end

    it 'releases items if the user leaves checkout' do
      user = create :user
      course = create :course, quantity: 1
      user.cart.add course

      user.cart.unlock

      expect(course.reserved).to eq 0
    end

    it 'releases items after a while'
  end

  describe 'transaction has completed' do
    it 'emails a receipt'
  end
end

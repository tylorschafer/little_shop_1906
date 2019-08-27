require 'rails_helper'

describe Merchant do
  describe "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "Relationships" do
    it {should have_many :items}
  end

  describe  "instance methods" do
    before :each do
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      @item_1 = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    end

    it "#has_order will return true if that merchant has an order" do

      expect(@brian.has_order).to eq(false)

      order = Order.create!(name: 'Tylor Schafer', address: '123 Fake Lane', city: 'Denver', state: 'CO', zip: 80130, grand_total: 10)
      order.order_items.create!(
        item_id: @item_1.id,
        price: @item_1.price,
        quantity: 1,
        sub_total: 10
      )

      expect(@brian.has_order).to eq(true)
    end

  end
end

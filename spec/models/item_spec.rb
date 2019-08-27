require 'rails_helper'

describe Item do
  describe "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :image }
    it { should validate_presence_of :inventory }
    it { should validate_inclusion_of(:active?).in_array([true,false]) }
  end

  describe "Relationships" do
    it {should belong_to :merchant}
    it {should have_many :reviews}
    it {should have_many :order_items}
    it {should have_many(:orders).through(:order_items)}
  end

  describe "instance methods" do
    before :each do
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      @item_1 = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @item_1.reviews.create(title: "Santi's review", content: "This product isn't great", rating: 1)
    end

    it "#has_order will return true if that item is on order" do

      expect(@item_1.has_order).to eq(false)

      order = Order.create!(name: 'Tylor Schafer', address: '123 Fake Lane', city: 'Denver', state: 'CO', zip: 80130, grand_total: 10)
      order.order_items.create!(
        item_id: @item_1.id,
        price: @item_1.price,
        quantity: 1,
        sub_total: 10
      )

      expect(@item_1.has_order).to eq(true)
    end

    it "#update_inventory will update item inventory after an order is placed" do

      expect(@item_1.inventory).to eq(32)

      order = Order.create!(name: 'Tylor Schafer', address: '123 Fake Lane', city: 'Denver', state: 'CO', zip: 80130, grand_total: 10)
      order.order_items.create!(
        item_id: @item_1.id,
        price: @item_1.price,
        quantity: 1,
        sub_total: 10
      )
      @item_1.update_inventory

      expect(@item_1.inventory).to eq(31)

    end
  end
end

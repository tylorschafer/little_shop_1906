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
      @item_2 = @brian.items.create(name: "Raptorskins", description: "This is different", price: 80, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 8)
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

    it "#items_count will count the total number of different items carried by that merchant" do
      expect(@brian.items_count).to eq(2)
    end

    it "#average_item_price will return the average price of all items" do

    end

    it "#distinct cities returns all disctinct cities merchant items have been ordered" do

    end

  end
end

require 'rails_helper'

describe 'Order Index Page' do
  before :each do
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @item_1 = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    @item_2 = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
    @items = [@item_1,@item_2]
  end
  # it "Can't access order index without items in cart" do
  #
  #   visit '/order'
  #
  #   expect(current_path).to eq('/items')
  #   expect(page).to have_content('Sorry, you have no items in your cart to process an order')
  # end

#   As a visitor
# When I check out from my cart
# On the new order page I see the details of my cart:
# - the name of the item
# - the merchant I'm buying this item from
# - the price of the item
# - my desired quantity of the item
# - a subtotal (price multiplied by quantity)
# - a grand total of what everything in my cart will cost
# I also see a form to where I must enter my shipping information for the order:
# - name
# - address
# - city
# - state
# - zip
# I also see a button to 'Create Order'

  it "I see all the details of my cart" do
    cart = Cart.new({
        "#{@item_1.id}" => 2,
        "#{@item_2.id}" => 1
      })

    visit '/cart'

    @items.each do |item|
      within "#item-#{item.id}" do
        expect(page).to have_link(item.name)
        expect(page).to have_content("Merchant: #{item.merchant.name}")
        expect(page).to have_content("Price: #{item.name}")
        expect(page).to have_content("Quantity: #{cart.count_of(item.id)}")
        expect(page).to have_content("Subtotal: #{cart.subtotal(item.id)}")
      end
    end

    expect(page).to have_content("Grand Total: #{cart.grand_total}")
  end

  it "I see a form with prepoulated text to enter my shipping information" do

  end
end

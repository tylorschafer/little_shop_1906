require 'rails_helper'

describe 'When I fill out all order information' do
  before :each do
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @item_1 = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    @item_2 = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)
    @items = [@item_1,@item_2]
    @item_1.reviews.create(title: "Santi's review", content: "This product isn't great", rating: 1)
    @item_2.reviews.create(title: "Meg's Review", content: "I really like this!", rating: 5)
  end

  it "An order is created and saved in database, and all info is displayed on the show page" do

    name = 'Tylor Schafer'
    address = '123 fake lane'
    city = 'Denver'
    state = 'Colorado'
    zip = '80124'

    cart = Cart.new({
        "#{@item_1.id}" => 1,
        "#{@item_2.id}" => 1
      })

    @items.each do |item|
      visit "/items/#{item.id}"

      click_button 'Add to Cart'
    end

    visit '/cart'

    click_button 'Checkout'

    within '#customer-info' do
      fill_in 'Name', with: name
      fill_in 'Address', with: address
      fill_in 'City', with: city
      fill_in 'State', with: state
      fill_in 'Zip', with: zip
      click_button 'Create Order'
    end

    new_order = Order.last

    expect(current_path).to eq("/orders/#{new_order.id}")

    @items.each do |item|
      within "#review-item-#{item.id}" do
        expect(page).to have_link(item.name)
        expect(page).to have_content("Merchant: #{item.merchant.name}")
        expect(page).to have_content("Price: $#{item.price}")
        expect(page).to have_content("Quantity: 1")
        expect(page).to have_content("Subtotal: $#{cart.sub_total(item)}")
      end
    end

    expect(page).to have_content("Grand Total: $#{cart.grand_total}")
    expect(page).to have_content("Order Place On: #{new_order.created_at.strftime("%Y-%m-%d")}")
  end
end

require 'rails_helper'

describe 'Merchant Show Page' do
  before :each do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
    @item_1 = @bike_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    @item_2 = @bike_shop.items.create(name: "Raptorskins", description: "This is different", price: 80, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 8)
  end

  it 'I can see a merchants name, address, city, state, zip' do
    visit "/merchants/#{@bike_shop.id}"

    expect(page).to have_content("Brian's Bike Shop")
    expect(page).to have_content("123 Bike Rd.\nRichmond, VA 23137")
  end

  it 'I can see a link to visit the merchant items' do
    visit "/merchants/#{@bike_shop.id}"

    expect(page).to have_link("All #{@bike_shop.name} Items")

    click_on "All #{@bike_shop.name} Items"

    expect(current_path).to eq("/merchants/#{@bike_shop.id}/items")
  end

  it "I can see statistics about that merchant" do

    order_1 = Order.create!(name: 'Tylor Schafer', address: '123 Fake Lane', city: 'Fakeville', state: 'CO', zip: 80130, grand_total: 10)
    order_1.order_items.create!(
      item_id: @item_2.id,
      price: @item_2.price,
      quantity: 1,
      sub_total: 80
    )
    order_2 = Order.create!(name: 'Tylor Schafer', address: '123 Fake Lane', city: 'Denver', state: 'CO', zip: 80130, grand_total: 10)
    order_2.order_items.create!(
      item_id: @item_1.id,
      price: @item_1.price,
      quantity: 1,
      sub_total: 10
    )

    visit "/merchants/#{@bike_shop.id}"

    within "#merchant-stats" do
      expect(page).to have_content("Total Items: 2")
      expect(page).to have_content("Average Item Price: $45.0")
      expect(page).to have_content("Orders shipped to: Denver Fakeville")
    end
  end
end

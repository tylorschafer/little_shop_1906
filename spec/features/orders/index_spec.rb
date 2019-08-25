require 'rails_helper'

describe 'Order Index Page' do
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

  # it "Can't access order index without items in cart" do
  #
  #   visit '/order'
  #
  #   expect(current_path).to eq('/items')
  #   expect(page).to have_content('Sorry, you have no items in your cart to process an order')
  # end

  it "I see all the details of my cart" do

    @items.each do |item|
      visit "/items/#{item.id}"

      click_button 'Add to Cart'
    end

    visit '/cart'

    click_button 'Checkout'

    expect(current_path).to eq('/order')

    cart = Cart.new({
        "#{@item_1.id}" => 1,
        "#{@item_2.id}" => 1
      })

    @items.each do |item|
      within "#review-item-#{item.id}" do
        expect(page).to have_link(item.name)
        expect(page).to have_content("Merchant: #{item.merchant.name}")
        expect(page).to have_content("Price: $#{item.price}")
        expect(page).to have_content("Quantity: #{cart.count_of(item.id)}")
        expect(page).to have_content("Subtotal: $#{cart.sub_total(item)}")
      end
    end
    expect(page).to have_content("Grand Total: $#{cart.grand_total}")
  end

  it "I see a form with prepoulated text to enter my shipping information" do

    visit "/items/#{@item_1.id}"

    click_button 'Add to Cart'

    visit '/cart'

    click_button 'Checkout'

    visit '/order'

    expect(find_field('Name'))
    expect(find_field('Address'))
    expect(find_field('City'))
    expect(find_field('State'))
    expect(find_field('Zip'))
    expect(find_button('Create Order'))
  end
end

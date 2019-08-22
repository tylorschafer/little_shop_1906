require 'rails_helper'

describe 'cart show page' do
  before :each do
    @merchant = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @item_1 = @merchant.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @item_2 = @merchant.items.create(name: "Raptorskins", description: "This is different", price: 80, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 8)
    @items = [@item_1,@item_2]
  end
  it 'I see all my items I added to the cart' do

    visit "/items/#{@item_1}"

    click_button 'Add to Cart'

    visit "/items/#{@item_2}"

    click_button 'Add to Cart'

    visit '/cart'

    @items.each do |item|
      within "#item-#{item.id}" do
        expect(page).to have_content(item.name)
        expect(page).to have_css("img[src*='#{item.image}']")
        expect(page).to have_content(item.merchant.name)
        expect(page).to have_content(item.price)
        expect(page).to have_content("Quantity: 1")
      end
    end
  end

  it "I can see a subtotal of items with multiple quantities" do

    visit "/items/#{@item_1}"

    click_button 'Add to Cart'

    click_button 'Add to Cart'

    visit '/cart'

    within "#item-#{item.id}" do
      expect(page).to have_content("Quantity: 2")
      expect(page).to have_content("Subtotal: $200")
    end

  end

  it "I can see a grand total the cost of everything in my cart" do
    visit "/items/#{@item_1}"

    click_button 'Add to Cart'
    click_button 'Add to Cart'

    visit "/items/#{@item_2}"

    click_button 'Add to Cart'
    click_button 'Add to Cart'

    visit '/cart'

    expect(page).to have_content("Grand Total: $360")
  end
end

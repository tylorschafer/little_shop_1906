require 'rails_helper'

describe 'When a user adds items to their cart' do
  before :each do
    @merchant = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @item_1 = @merchant.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @item_2 = @merchant.items.create(name: "Gatorskinsduex", description: "This is different", price: 80, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 8)
  end

  it 'displays a message' do

    visit '/items'

    within("#item-#{@item_1.id}") do
      click_button "Add to Cart"
    end

    expect(page).to have_content("You now have 1 #{@item_1.name} in your cart.")

    visit "/merchants/#{@merchant.id}/items"

    within("#item-#{@item_2.id}") do
      click_button "Add to Cart"
    end

    expect(page).to have_content("You now have 1 #{@item_2.name} in your cart.")

  end

  it "the message correctly increments for multiple items in cart" do

    visit "/items"

    within("#item-#{@item_1.id}") do
      click_button "Add to Cart"
    end
    expect(page).to have_content("You now have 1 #{@item_1.name} in your cart.")

    within("#item-#{@item_2.id}") do
      click_button "Add to Cart"
    end

    expect(page).to have_content("You now have 1 #{@item_2.name} in your cart.")

    within("#item-#{@item_1.id}") do
      click_button "Add to Cart"
    end

    expect(page).to have_content("You now have 2 #{@item_1.name} in your cart.")
  end
end

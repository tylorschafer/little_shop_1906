require 'rails_helper'

describe 'cart show page' do
  before :each do
    @merchant = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @item_1 = @merchant.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 3)
    @item_2 = @merchant.items.create(name: "Raptorskins", description: "This is different", price: 80, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 8)
    @items = [@item_1,@item_2]
  end
  it 'I see all my items I added to the cart' do

    visit "/items/#{@item_1.id}"

    click_button 'Add to Cart'

    visit "/items/#{@item_2.id}"

    click_button 'Add to Cart'

    visit '/cart'

    @items.each do |item|
      within "#item-#{item.id}" do
        expect(page).to have_content(item.name)
        expect(page).to have_css("img[src*='#{item.image}']")
        expect(page).to have_content("Sold by: #{item.merchant.name}")
        expect(page).to have_content("Price: $#{item.price}")
        expect(page).to have_content("Quantity: 1")
      end
    end
  end

  it "I can see a subtotal of items with multiple quantities" do

    2.times do
      visit "/items/#{@item_1.id}"

      click_button 'Add to Cart'
    end

    visit '/cart'

    within "#item-#{@item_1.id}" do
      expect(page).to have_content("Quantity: 2")
      expect(page).to have_content("Subtotal: $200")
    end

  end

  it "I can see a grand total the cost of everything in my cart" do
    2.times do
      visit "/items/#{@item_1.id}"

      click_button 'Add to Cart'
    end

    2.times do
      visit "/items/#{@item_2.id}"

      click_button 'Add to Cart'
    end

    visit '/cart'

    expect(page).to have_content("Grand Total: $360")
  end

  it "I can see a link to empty my cart if the cart is not empty" do

    visit "/items/#{@item_2.id}"

    click_button 'Add to Cart'

    visit '/cart'

    expect(page).to have_link('Empty Cart')

    click_link 'Empty Cart'

    expect(current_path).to eq('/cart')

    expect(page).to_not have_link('Empty Cart')
    expect(page).to_not have_content(@item_2.name)
    expect(page).to_not have_css("img[src*='#{@item_2.image}']")
    expect(page).to_not have_content("Sold by: #{@item_2.merchant.name}")
    expect(page).to_not have_content("Price: $#{@item_2.price}")
    expect(page).to_not have_content("Quantity: 1")
    expect(page).to have_content("Grand Total: $0")
  end

  it "I can see links to remove certain items from the cart" do
    @items.each do |item|
      2.times do
        visit "/items/#{item.id}"
        click_button 'Add to Cart'
      end
    end

    visit '/cart'

    expect(page).to have_link('Remove Item')

    within("#item-#{@item_1.id}") do
      click_link 'Remove Item'
    end

    expect(page).to_not have_css("#item-#{@item_1.id}")
    expect(page).to_not have_content(@item_1.name)
  end

  it "I can see buttons to increase or decrease quantity of an item" do
    visit "/items/#{@item_1.id}"

    click_button 'Add to Cart'

    visit '/cart'

    within("#item-#{@item_1.id}") do
      click_button 'Add'
      expect(page).to have_content("Quantity: 2")
      click_button 'Add'
      expect(page).to have_content("Quantity: 3")
      click_button 'Add'
    end
    expect(page).to have_content("Sorry this is the maximum order size allowed for this item.")

    within("#item-#{@item_1.id}") do
      click_button 'Subtract'
      expect(page).to have_content("Quantity: 2")
      click_button 'Subtract'
      expect(page).to have_content("Quantity: 1")
      click_button 'Subtract'
      end
      expect(page).to_not have_css("#item-#{@item_1.id}")
      expect(page).to_not have_content(@item_1.name)
  end

  it "when there are items in my cart I see a button to checkout" do
    visit '/cart'

    expect(page).to_not have_button('Checkout')

    visit "/items/#{@item_1.id}"

    click_button 'Add to Cart'

    visit '/cart'

    expect(page).to have_button('Checkout')

    click_button('Checkout')

    expect(current_path).to eq('/order')
  end
end

require 'rails_helper'

describe 'When I fill out all order information' do
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
      visit "/items/#{@item_1.id}"

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

    expect(current_path).to eq("/orders/#{new_order}")

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
    expect(page).to have_content("Order Place On: #{new_order.created_at.strftime("%Y-%m-%d")}")
  end
end

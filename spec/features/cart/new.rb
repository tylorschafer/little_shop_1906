require 'rails_helper'

describe 'Add Item to Cart' do
  describe 'When a user adds items to their cart' do
    before :each do
      @merchant = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @item_1 = @merchant.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @item_2 = @merchant.items.create(name: "Raptorskins", description: "This is different", price: 80, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 8)
      @items = [@item_1,@item_2]
      @item_1.reviews.create(title: "Gets the job done", content: "My pooch loves this product, has lasted for weeks already!", rating: 5.0)
      @item_2.reviews.create(title: "Good Buy!", content: "This is a great toy, very durable and good quality", rating: 4.0)
    end

    it 'It displays a message' do

      @items.each do |item|

        visit "/items/#{item.id}"

          click_button "Add to Cart"

        expect(page).to have_content("You now have 1 #{item.name} in your cart.")
      end
    end

    describe 'When adding multiples of items' do
      it "The message correctly increments for multiple items in cart" do

        @items.each do |item|

          visit "/items/#{item.id}"

          click_button "Add to Cart"

          expect(page).to have_content("You now have 1 #{item.name} in your cart.")

          visit "/items/#{item.id}"

          click_button "Add to Cart"

          expect(page).to have_content("You now have 2 #{item.name} in your cart.")
        end
      end
    end

    it 'The indicator displays the total count of items in the cart' do

      visit "/items/#{@item_1.id}"

      within ".topnav" do
      expect(page).to have_content("Cart: 0")
      end

      click_button "Add to Cart"

      within ".topnav" do
      expect(page).to have_content("Cart: 1")
      end

      visit "/items/#{@item_2.id}"

      click_button "Add to Cart"

      within ".topnav" do
      expect(page).to have_content("Cart: 2")
      end

      visit "/items/#{@item_1.id}"

      click_button "Add to Cart"

      within ".topnav" do
      expect(page).to have_content("Cart: 3")

      end
    end
  end
end

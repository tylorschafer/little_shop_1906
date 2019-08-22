require 'rails_helper'

describe 'Item show page' do
  describe 'When a user adds items to their cart' do
    before :each do
      @merchant = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @item_1 = @merchant.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @item_2 = @merchant.items.create(name: "Raptorskins", description: "This is different", price: 80, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 8)
      @items = [@item_1,@item_2]
    end

    it 'displays a message' do

      @items.each do |item|

        visit "/items/#{item.id}"

          click_button "Add to Cart"

        expect(page).to have_content("You now have 1 #{item.name} in your cart.")
      end
    end

    describe 'when adding multiples of items' do
      it "the message correctly increments for multiple items in cart" do

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

    describe 'when adding items' do
      it 'displays the total number of items in the cart' do

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
end

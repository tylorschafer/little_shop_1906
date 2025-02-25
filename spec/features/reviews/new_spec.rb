require 'rails_helper'

describe "Create new review" do
  describe "when i visit the item show page" do
    before :each do
      @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @title = "review"
      @content = "this product is great"
      @rating = 4
      @chain.reviews.create(title: "Santi's review", content: "This product isn't great", rating: 1)

    end
    it "I can create a new review by filling out a form" do

      visit "items/#{@chain.id}"

      click_link "Add New Review"

      expect(current_path).to eq("/items/#{@chain.id}/reviews/new")

      fill_in :title, with: @title
      fill_in :content, with: @content
      fill_in :rating, with: @rating

      click_button "Create Review"

      new_review = Review.last
      expect(current_path).to eq("/items/#{@chain.id}")
      expect(page).to have_content('Thank you for your review submission.')
      expect(new_review.title).to eq(@title)
      expect(new_review.content).to eq(@content)
      expect(new_review.rating).to eq(@rating)
    end

    it 'I will be redirected back to review new
    and a flash warning will display if I do not fill out form completley.' do
      visit "items/#{@chain.id}"

      click_link "Add New Review"

      fill_in :title, with: @title
      fill_in :content, with: @content

      click_button "Create Review"

      expect(current_path).to eq("/items/#{@chain.id}/reviews/new")

      within ".error" do
        expect(page).to have_content("Rating Number must be between 1 and 5")
      end
    end
  end
end

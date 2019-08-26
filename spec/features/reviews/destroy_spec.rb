require 'rails_helper'

describe 'review delete' do
  describe 'when I visit an item show page' do
    it 'I can delete a review' do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      review_1 = chain.reviews.create(title: "Santi's review", content: "This product isn't great", rating: 1)
      review_2 = chain.reviews.create(title: "Meg's Review", content: "I really like this!", rating: 5)

      visit "/items/#{chain.id}"

      within "#review-#{review_1.id}" do
      expect(page).to have_link("Delete Review")

      click_on "Delete Review"
      end

      expect(current_path).to eq("/items/#{chain.id}")
      expect(page).to_not have_css("#review-#{chain.id}")
      expect(page).to have_content(review_2.title)
      expect(page).to have_content(review_2.content)
      expect(page).to have_content("Rating: 5")
    end
  end
end

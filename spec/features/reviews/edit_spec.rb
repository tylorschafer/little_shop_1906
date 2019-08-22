# As a visitor,
# When I visit an item's show page
# I see a link to edit the review next to each review.
# When I click on this link, I am taken to an edit review path
# On this new page, I see a form that includes:
# - title
# - numeric rating
# - text of the review itself
# I can update any of these fields and submit the form.
# When the form is submitted, I should return to that item's
# show page and I should see my updated review
require 'rails_helper'

RSpec.describe "as a visitor" do
  describe "after i visit a item page i can clic on updating a review that i made" do
    before :each do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @tire.reviews.create(title: "Santi's review", description: "this product is trash", reating: 1)
    end
      visit "/items/#{@tire.id}"

      expect(page).to have_link("Edit Review")

      click_on "Edit Review"

      expect(current_path).to eq("/items/#{@tire.id}/review_edit")
      expect(page).to have_link("Santi's review")
      expect(find_field('title').value).to eq "Santi's review"
      expect(find_field('description').value).to eq "this product is trash"
      expect(find_field('rating').value).to eq 1

    end
    it 'can edit review ifo by filling the form and clicking submit' do
      visit "/items/#{@tire.id}"
      click_on "Update review"
      fild_in 'title', with: "Jhon's review"
      fild_in 'description', with: "this product id alright"
      fild_in 'rating', with: 3


  end
end

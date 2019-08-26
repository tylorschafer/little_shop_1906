require 'rails_helper'

describe "Item show page" do
  describe "I can edit review content" do
    before :each do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @review_1 = @tire.reviews.create(title: "Santi's review", content: "This product isn't great", rating: 1)
      @review_2 = @tire.reviews.create(title: "Meg's Review", content: "I really like this!", rating: 5)
    end

    it 'I can see the prepopulated fields of that item' do
      visit "/items/#{@tire.id}"

      within "#review-#{@review_1.id}" do
      expect(page).to have_link("Edit Review")
      click_on "Edit Review"
      end

      expect(current_path).to eq("/items/#{@tire.id}/#{@review_1.id}/edit")
      expect(find_field('Title').value).to eq "Santi's review"
      expect(find_field('Content').value).to eq "This product isn't great"
      expect(find_field('Rating').value).to eq '1'
    end

    it 'I can edit review content by filling the form and clicking submit' do
      title = "John's Review"
      content = "This product is alright."
      rating = 3

      visit "/items/#{@tire.id}"

      within "#review-#{@review_1.id}" do
      expect(page).to have_link("Edit Review")
      click_on "Edit Review"
      end

      fill_in 'title', with: title
      fill_in 'content', with: content
      fill_in 'rating', with: rating

      click_button "Update Review"

      expect(current_path).to eq("/items/#{@tire.id}")
      expect(page).to have_content(title)
      expect(page).to have_content(content)
      expect(page).to have_content("Rating: #{rating}")
    end
  end
end

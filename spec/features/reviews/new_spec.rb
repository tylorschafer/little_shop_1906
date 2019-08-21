describe "Create new review" do
  describe "when i visit the item show page" do
    before :each do
      @bike_shop = Merchant.create(
        name: "Brian's Bike Shop",
        address: '123 Bike Rd.',
        city: 'Denver',
        state: 'CO',
        zip: 80203
      )
      @chain = @bike_shop.items.create(
        name: "Chain", description: "It'll never break!",
        price: 50,
        image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588",
        inventory: 5
      )
    end
    it "i can create a new review by filling out a form" do

      title = "review"
      content = "theis product is great"
      rating = 4

      visit "items/#{@chain.id}"
      click_link "Add New Review"
      expect(current_path).to eq("/items/#{@chain.id}/reviews/new")
      fill_in :title, with: title
      fill_in :content, with: content
      fill_in :rating, with: rating

      click_button "Create Review"

      new_review = Review.last
      expect(current_path).to eq("/items/#{@chain.id}")
      expect(new_review.title).to eq(title)
      expect(new_review.content).to eq(content)
      expect(new_review.rating).to eq(rating)

    end
    it "if i don fill in the 3 main parts of the reviews" do
      title = "review form user 1"
      content = "theis product is great"
      rating = 4

      
  end
end

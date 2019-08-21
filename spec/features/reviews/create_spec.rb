describe "Saving new review correctly" do
  describe "when i fill in the review i have to complete all the sections" do
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
    it "if i don fill in the 3 main parts of the reviews" do
      title = "review form user 1"
      content = "theis product is great"
      rating = 4

      visit "items/#{@cahin.id}"
      click_link "Add New Review"
      expect(current_path).to eq("/items/#{@chain.id}/reviews/new")
      fill_in :title, with: title
      fill_in :content, with: content

      click_button "Create Review"

      new_review = Review.last
      expect(page).to have_content("missing review content")

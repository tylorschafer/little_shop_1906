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
      title = "review"
      content = "theis product is great"
      rating = 4

require 'rails_helper'

describe Review do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :content }
    it { should validate_numericality_of(:rating).with_message('Number must be between 1 and 5')}
  end

  describe 'Relationships' do
    it {should belong_to :item}
  end

  describe "Class Methods" do
    before :each do
      @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      @pull_toy = @dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @pull_toy_review_1 = @pull_toy.reviews.create(title: "Gets the job done", content: "My pooch loves this product, has lasted for weeks already!", rating: 5.0)
      @pull_toy_review_2 = @pull_toy.reviews.create(title: "Good Buy!", content: "This is a great toy, very durable and good quality", rating: 4.0)
      @pull_toy_review_3 = @pull_toy.reviews.create(title: "Could be better", content: "Meh meh meh meh", rating: 3.0)
      @pull_toy_review_4 = @pull_toy.reviews.create(title: "It's ok", content: "It's fine for the price", rating: 2.0)
    end
    it ".top_rated can show top three review ratings" do
      expect(Review.top_rated(@pull_toy.id)).to eq(
        [@pull_toy_review_1,@pull_toy_review_2,@pull_toy_review_3]
      )
    end

    it ".bottom_rated can show bottom three review ratings" do
      expect(Review.bottom_rated(@pull_toy.id)).to eq(
        [@pull_toy_review_4,@pull_toy_review_3,@pull_toy_review_2]
      )
    end

    it ".average_rating can show all reviews average rating" do
      expect(Review.average_rating(@pull_toy.id)).to eq(3.5)
    end
  end
end

require 'rails_helper'

RSpec.describe 'item show page', type: :feature do
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
    @review_1 = @chain.reviews.create(title: "Gets the job done", content: "My pooch loves this product, has lasted for weeks already!", rating: 5.0)
    @review_2 = @chain.reviews.create(title: "Good Buy!", content: "This is a great toy, very durable and good quality", rating: 4.0)
    @review_3 = @chain.reviews.create(title: "Could be better", content: "Meh meh meh meh", rating: 3.0)
    @review_4 = @chain.reviews.create(title: "It's ok", content: "It's fine for the price", rating: 2.0)
    @reviews = [@review_1,@review_2,@review_3,@review_4]
  end
  it 'shows item info' do

    visit "items/#{@chain.id}"

    expect(page).to have_link(@chain.merchant.name)
    expect(page).to have_content(@chain.name)
    expect(page).to have_content(@chain.description)
    expect(page).to have_content("Price: $#{@chain.price}")
    expect(page).to have_content("Active")
    expect(page).to have_content("Inventory: #{@chain.inventory}")
    expect(page).to have_content("Sold by: #{@bike_shop.name}")
    expect(page).to have_css("img[src*='#{@chain.image}']")
  end

  it 'shows reviews for that item' do

    visit "items/#{@chain.id}"

    @reviews.each do |review|
      within "#review-#{review.id}" do
        expect(page).to have_content(review.title)
        expect(page).to have_content(review.content)
        expect(page).to have_content("Rating: #{review.rating}")
      end
    end
  end

  it 'shows a link to create a new review' do
    visit "items/#{@chain.id}"

    within "#new-review" do
      expect(page).to have_link('Add New Review')
    end
  end

  it 'I can see statistics about all reviews' do
    top_reviews = "#{@review_1.title} : #{@review_1.rating}\n#{@review_2.title} : #{@review_2.rating}\n#{@review_3.title} : #{@review_3.rating}"
    bottom_reviews = "#{@review_4.title} : #{@review_4.rating}\n#{@review_3.title} : #{@review_3.rating}\n#{@review_2.title} : #{@review_2.rating}"

    visit "items/#{@chain.id}"

    within "#top-reviews" do
      expect(page).to have_content("Top Reviews:\n#{top_reviews}")
    end

    within "#low-reviews" do
      expect(page).to have_content("Lowest Reviews:\n#{bottom_reviews}")
    end

    within "#average-reviews" do
      expect(page).to have_content("Average Review Rating: 3.5")
    end
      end

    it 'I can add items with the Add to Cart Button' do
      within  ".item-show-grid" do
        click_button 'Add to Cart'
      end
      within ".topnav" do
        expect(page).to have_content('Cart: 1')
    end
  end
end

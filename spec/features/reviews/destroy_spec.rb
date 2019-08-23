require 'rails_helper'
RSpec.describe "As a visitor" do
  describe "when i visits an item's show page" do

    it "i can delete a review"do

      item_review = Review.create(title: "Santi's", :content: "this product is greate", rating: 4)

      visit "items/#{item_review.id}"
      click_on "Delete Review"

      expect(current_path).to eq('/items/item_id')
      expect(page).to_not have_css("#item-#{item_review.id}")
    end

class Review < ApplicationRecord
  belongs_to :item

  validates_presence_of :title, :content, :rating

  def self.top_rated
    Review.order(:rating).last(3).reverse
  end

  def self.bottom_rated
    Review.order(:rating).first(3)
  end

  def self.average_rating
    Review.average(:rating)
  end

end

class Review < ApplicationRecord
  belongs_to :item

  validates_presence_of :title, :content
  validates :rating, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, message: "Number must be between 1 and 5"}

  def self.top_rated(item_id)
    all.where("item_id = #{item_id}").order(:rating).last(3).reverse
  end

  def self.bottom_rated(item_id)
    all.where("item_id = #{item_id}").order(:rating).first(3)
  end

  def self.average_rating(item_id)
    all.where("item_id = #{item_id}").average(:rating)
  end
end

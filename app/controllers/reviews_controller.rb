class ReviewsController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
  end

  def create
    item = Item.find(params[:id])
    review = item.reviews.create(review_params)
    if Review.last != review
      flash[:notice] = 'We were unable to create your review as you did not fill the entire form.'
      redirect_to "/items/#{item.id}/reviews/new"
    else
      flash[:notice] = 'Thank you for your review submission.'
      redirect_to "/items/#{item.id}"
    end
  end

  private
  def review_params
    params.permit(:title, :content, :rating)
  end
end

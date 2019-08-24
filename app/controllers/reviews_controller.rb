class ReviewsController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
  end

  def create
    item = Item.find(params[:id])
    review = item.reviews.create(review_params)
    if review.save
      flash[:success] = 'Thank you for your review submission.'
      redirect_to "/items/#{item.id}"
    else
      flash[:error] = review.errors.full_messages
      redirect_to "/items/#{item.id}/reviews/new"
    end
  end

  def edit
    @item_id = params[:item_id]
    @review = Review.find(params[:review_id])
  end

  def update
    item = Item.find(params[:item_id])
    review = Review.find(params[:review_id])
    new_review = review.update(review_params)
    if new_review
      flash[:success] = 'You have updated your review.'
      redirect_to "/items/#{item.id}"
    else
      flash[:error] = review.errors.full_messages
      redirect_to "/items/#{item.id}/#{review.id}/edit"
    end
  end

  def destroy
    item_id = params[:item_id]
    Review.find(params[:review_id]).destroy
    redirect_to "/items/#{item_id}"
  end

  private
  def review_params
    params.permit(:title, :content, :rating)
  end
end

class ReviewsController < ApplicationController
  def new
    @item = Item.find(params[:item_id])

  end
  def create
    item = Item.find(params[:id])
    item.reviews.create!(review_params)
    redirect_to "/items/#{item.id}"
  end
  def review_params
    params.permit(:title, :content, :rating)
  end
  def edit
    @item = Item.find(params[:id])
  end
  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to "/items/#{item.id}"
  end
end

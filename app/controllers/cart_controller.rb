class CartController < ApplicationController

  def add_item
    item = Item.find(params[:item_id])
    flash[:notice] = "You now have 1 #{item.name} in your cart."
    redirect_to '/items'
  end

end

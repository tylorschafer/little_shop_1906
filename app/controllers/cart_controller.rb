class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def update
    item = Item.find(params[:item_id])
    cart.add_item(item.id)
    session[:cart] = cart.contents
    quantity = cart.count_of(item.id)
    flash[:notice] = "You now have #{pluralize(quantity, "#{item.name}")} in your cart."
    redirect_to '/items'
  end

  def index
  end

  def remove
    if session[:cart][params[:item_id]] < 2
      delete
    else
      session[:cart][params[:item_id]] -= 1
      redirect_to '/cart'
    end
  end

  def add
    item = Item.find(params[:item_id])
    if session[:cart][params[:item_id]] == item.inventory
      flash[:error] = "Sorry this is the maximum order size allowed for this item."
      redirect_to '/cart'
    else
      session[:cart][params[:item_id]] += 1
      redirect_to '/cart'
    end
  end

  def delete
    session[:cart] = cart.remove_item(params[:item_id])
    redirect_to '/cart'
  end

  def destroy
    session[:cart] = Hash.new(0)
    redirect_to '/cart'
  end
end

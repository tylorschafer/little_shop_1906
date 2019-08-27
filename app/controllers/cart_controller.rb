class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    cart.contents.each do |item_id, quantity|
      if Item.where(id: item_id).empty?
        session[:cart].delete(item_id)
      end
    end
  end

  def update(item = Item.find(params[:item_id]),  add = params[:add])
    if (cart.count_of(item.id) == item.inventory) && (add == 'true')
      flash[:error] = "Sorry this is the maximum order size allowed for this item."
    elsif (cart.count_of(item.id) <= 1) && (add == 'false')
      delete(false)
    else
      add_or_subtract(add, item.id)
      update_message(item)
    end
    find_redirect
  end

  def add_or_subtract(add, item_id)
    if add == 'false'
      cart.subtract_item(item_id)
    else
      cart.add_item(item_id)
    end
  end

  def update_message(item)
    quantity = cart.count_of(item.id)
    flash[:notice] = "You now have #{pluralize(quantity, "#{item.name}")} in your cart."
  end

  def find_redirect
    session[:cart] = cart.contents
    if params[:path] == '/cart' && cart.contents != {}
      redirect_to '/cart'
    else
      redirect_to '/items'
    end
  end

  def delete(redirect = true)
    session[:cart] = cart.remove_item(params[:item_id])
    redirect_to '/cart' unless redirect == false
    session[:cart] = cart.contents unless redirect == false
  end

  def destroy
    session[:cart] = Hash.new(0)
    redirect_to '/cart'
  end
end

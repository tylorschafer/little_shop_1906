class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show
    if cart.contents.empty?
      flash[:notice] = "You have no items in your cart."
    else
      cart.contents.each do |item_id, quantity|
        session[:cart].delete(item_id) if cart.invalid_item?(item_id)
      end
    end
  end

  def update(item = Item.find(params[:item_id]),  add = params[:add])
    if cart.max_item_count?(item, add)
      flash[:error] = "Sorry this is the maximum order size allowed for this item."
    elsif cart.min_item_count?(item, add)
      delete(false)
    else
      add_or_subtract(add, item.id)
      update_message(item)
    end
    find_redirect
  end

  def add_or_subtract(add, item_id)
    cart.subtract_item(item_id) if add == 'false'
    cart.add_item(item_id) if add == 'true'
  end

  def update_message(item)
    quantity = cart.count_of(item.id)
    flash[:notice] = "You now have #{pluralize(quantity, "#{item.name}")} in your cart."
  end

  def find_redirect
    session[:cart] = cart.contents
    if params[:path] == '/cart'
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

class OrdersController < ApplicationController
  before_action :verify_order, only: [:index]

  def verify_order
    if cart.contents == {}
      redirect_to '/items'
      flash[:error] = 'Sorry, you have no items in your cart to process an order'
    else
      render 'index'
    end
  end

  def index
  end

  def create
    order = Order.create(shipping_params)
    if order.save
      flash[:success] = 'Thank you for your order! Your products will arive in the next 20 - 30 business years.'
      redirect_to "/order/#{order.id}"
    else
      flash[:error] = order.errors.full_messages
      redirect_to '/order'
    end
  end
end

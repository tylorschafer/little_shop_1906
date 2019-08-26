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

  def create_order_items(order_id)
    cart.cart_items.each do |item|
      OrderItem.create!(
        order_id: order_id,
        item_id: item.id,
        item_name: item.name,
        merchant_name: item.merchant.name,
        price: item.price,
        quantity: cart.count_of(item.id),
        sub_total: cart.sub_total(item)
      )
    end
  end

  def create
    params = shipping_params
    params[:grand_total] = cart.grand_total
    order = Order.create(params)
    if order.save
      create_order_items(order.id)
      flash[:success] = 'Thank you for your order! Your products will arive in the next 20 - 30 business years.'
      session[:cart] = Hash.new(0)
      redirect_to "/orders/#{order.id}"
    else
      flash[:error] = order.errors.full_messages
      redirect_to '/order'
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def shipping_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end

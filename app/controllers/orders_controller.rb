class OrdersController < ApplicationController
  before_action :verify_order, only: [:index]

  def index
  end

  def verify_order
    if cart.contents == {}
      redirect_to '/items'
      flash[:error] = 'Sorry, you have no items in your cart to process an order'
    end
  end

  def create_order_items(order_id)
    cart.cart_items.each do |item|
      orditem = OrderItem.create!(
        order_id: order_id,
        item_id: item.id,
        price: item.price,
        quantity: cart.count_of(item.id),
        sub_total: cart.sub_total(item)
      )
      item.update_inventory(orditem.quantity)
    end
  end

  def create
    order = Order.create(shipping_params)
    if order.save
      create_order_items(order.id)
      session[:cart] = Hash.new(0)
      redirect_to "/orders/#{order.id}"
    else
      flash[:error] = order.errors.full_messages
      redirect_to '/orders'
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def shipping_params
    ship_params = params.permit(:name, :address, :city, :state, :zip)
    ship_params[:grand_total] = cart.grand_total
    ship_params
  end
end

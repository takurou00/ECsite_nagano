class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def new
     @order = Order.new
     @addresses = current_customer.addresses
  end

  def index
    @orders = Order.page(params[:page]).per(8)
  end


  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    if params[:order][:selected_address] == "0"
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:selected_address] == "1"
      address=Address.find(params[:order][:customer_id])
      @order.address = address.address
      @order.name = address.name
      @order.postal_code = address.postal_code
    elsif params[:order][:selected_address] == "2"
    end
  end

  def create
    @sum = params[:order][:sum]
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items
    # @order.name = address.name
    @order.shipping_cost = 800
    @order.total_payment = (800+ @sum.to_i)
    @order.save
    # @order_detail = @cart_items
    @cart_items.each do |cart_item|
    order_detail = OrderDetail.new
    order_detail.id = cart_item.id
    order_detail.item_id = cart_item.item.id
    order_detail.order_id = @order.id
    order_detail.price = cart_item.item.price
    order_detail.amount = cart_item.amount
    # binding.pry
    order_detail.save
  end
    redirect_to orders_confirm_path
  end


  def complete
    CartItem.destroy_all
  end


  private
  def order_params
      params.require(:order).permit(:customer_id, :shipping_cost, :postal_code, :address, :name, :total_patment, :payment_method, :status, :last_name, :first_name)
  end
end

class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to orders_path
    else
      render :new
    end
  end

  def update
    if @order.update order_params
      redirect_to orders_path
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    redirect_to orders_path if @order.destroy
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:tracking_number, :product_id, :customer_id, :driver_id, :quantity, :total_price, :status)
  end
end

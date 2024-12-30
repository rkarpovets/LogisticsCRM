class OrderRequestsController < ApplicationController
  before_action :set_order_request, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    if current_user.admin?
      @order_requests = OrderRequest.all
    else
      @order_requests = current_user.order_requests
    end
  end

  def edit
  end

  def new
    @order_request = OrderRequest.new
  end

  def create
    @order_request = OrderRequest.new(order_request_params)
    @order_request.user = current_user

    if @order_request.save
      redirect_to order_requests_path
    else
      render :new
    end
  end

  def show
    @order_request = OrderRequest.find(params[:id])

    if !current_user.admin? && @order_request.user != current_user
      redirect_to root_path, alert: "You do not have permission to view this page."
    end
  end

  def destroy
    @order_request = OrderRequest.find(params[:id])
    @order_request.destroy
    redirect_to order_requests_path, notice: "Order Request Successfully Deleted"
  end

  def update
    if @order_request.update order_request_params
      redirect_to order_requests_path
    else
      render :edit
    end
  end

  private

  def order_request_params
    params.require(:order_request).permit(:product_id, :delivery_address, :quantity, :first_name, :last_name, :status)
  end

  def set_order_request
    @order_request = OrderRequest.find(params[:id])
  end
end

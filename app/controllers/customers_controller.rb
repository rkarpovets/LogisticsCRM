class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def edit
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to customers_path
    else
      render :new
    end
  end

  def update
    if @customer.update customer_params
      redirect_to customers_path
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @customer.destroy
    redirect_to customers_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :surname, :contact_number, :email, :address)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
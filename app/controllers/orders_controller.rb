class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    if user_signed_in? && @user.admin?
    @orders = Order.all
    elsif user_signed_in?
      @orders = @user.orders
    else
      redirect_to main_app.root_url, alert: "You are not logged in"
    end
  end

  def show
  end

  def new
  end

  def create
  end

  def destroy
  end

end
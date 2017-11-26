class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @orders = Order.where(user_id: current_user)
  end

  def show
  end

  def new
    @order = Order.new
  end

  def create
  end

  def destroy
  end

  private
  
     def order_params
       params.require(:order).permit( :total, :user_id, :product_ids => [])
     end
  

end
class Admin::OrdersController < AdminController

  before_action :find_order, on: [:ship,:shipped,:cancel,:return]

  def index
    @orders = Order.order("id DESC")
  end

  def show
    @order = Order.find(params[:id])
    @order_info = @order.info
    @order_items = @order.items
  end

  def ship
    @order.ship!
    redirect_to :back
  end

  def shipped
    @order.deliver!
    redirect_to :back
  end

  def cancel
    @order.cancell_order!
    redirect_to :back
  end

  def return
    @order.return_good!
    redirect_to :back
  end

  private
  def find_order
    @order = Order.find(params[:id])
  end

end

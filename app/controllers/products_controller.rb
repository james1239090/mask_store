class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])
    @color = params[:cart][:cart_items][:color_id]
    @dimension = params[:cart][:cart_items][:dimension_id]
    current_cart.add_product_to_cart(@product,@color,@dimension)
    flash[:notice] = "你已成功將#{@product.title} 加入購物車"
    redirect_to :back
  end
end

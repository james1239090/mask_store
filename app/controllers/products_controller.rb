class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if (!params[:cart].blank? && !params[:cart][:cart_items].blank? && !params[:cart][:cart_items][:color_id].blank? && !params[:cart][:cart_items][:dimension_id].blank?)
      @color = params[:cart][:cart_items][:color_id]
      @dimension = params[:cart][:cart_items][:dimension_id]
      @quantity = params[:cart][:cart_items][:quantity] || 1
      current_cart.add_product_to_cart(@product,@color,@dimension,@quantity)
      flash[:notice] = "你已成功將#{@product.title} 加入購物車"
    else
      flash[:warning] = "請選擇顏色或尺吋"
    end

    redirect_to :back
  end



end

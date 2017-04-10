class CartItemsController < ApplicationController
  def destroy
    @cart = current_cart
    @item = @cart.cart_items.find_by(product_id: params[:id])
    @product = @item.product

    @item.destroy

    flash[:warning] = "成功將#{@product.title}從購物車移除!"
    redirect_to :back
  end

  def update
    @cart = current_cart
    @item = @cart.cart_items.find_by(product_id: params[:id])

    @item.update(item_params)
    flash[:warning] = "成功將#{@item.product.title}數量更新為#{@item.quantity}"
    redirect_to carts_path

  end


  private
  def item_params
    params.require(:cart_item).permit(:quantity)
  end
end

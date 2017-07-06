class CartItemsController < ApplicationController
  def destroy
    @cart = current_cart
    @item = @cart.cart_items.find(params[:id])
    @product = @item.product

    @item.destroy

    flash[:warning] = "成功將#{@product.title}從購物車移除!"
    redirect_to :back
  end

  def update
    @cart = current_cart
    @item = @cart.cart_items.find(params[:id])

    if !item_params[:color_id].blank? && !item_params[:dimension_id].blank? && !item_params[:quantity].blank?
      @inventory = Inventory.getInventory(@item.product.id, params[:cart_item][:color_id], params[:cart_item][:dimension_id])
      if @inventory.first.quantity >= item_params[:quantity].to_i
        @item.update(item_params)
        flash[:notice] = "成功將#{@item.product.title}顏色、尺吋、數量更新"
      else
        flash[:warning] = "數量不足以加入購物車"
      end
    else
      flash[:warning] = "欄位資訊漏填"
    end

    redirect_to carts_path

  end


  private
  def item_params
    params.require(:cart_item).permit(:color_id,:dimension_id,:quantity)
  end
end

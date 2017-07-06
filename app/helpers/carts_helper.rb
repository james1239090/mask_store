module CartsHelper
  def render_cart_total_price(cart)
    cart.total_price
  end

  def render_cart_item_sub_total(cart_item)
    cart_item.product.price * cart_item.quantity
  end
end

class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product

  def add_product_to_cart(product, color, dimension)
    ci = cart_items.build
    ci.product = product
    ci.color_id = color
    ci.dimension_id = dimension
    ci.save
  end

  def total_price
    sum = 0
    cart_items.each do |cart_item|
      sum = sum + (cart_item.product.price * cart_item.quantity)
    end
    sum
  end

  def clean!
    cart_items.destroy_all
  end

  def find_cart_item(product)
    cart_items.find_by(product_id: product)
  end

end

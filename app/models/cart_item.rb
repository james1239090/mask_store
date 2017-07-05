class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  belongs_to :color
  belongs_to :dimension
end

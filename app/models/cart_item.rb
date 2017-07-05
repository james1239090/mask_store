class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  belongs_to :color
  belongs_to :dimension

  validates :product,:color,:dimension, :quantity ,presence: true
  validates :quantity, numericality: {less_than_or_equal_to: :getInventoryQty}, presence: true


  private
  def getInventoryQty
    inventory = Inventory.getInventory(self.product_id, self.color_id, self.dimension_id).first
    quantity = inventory.quantity
    quantity
  end
end

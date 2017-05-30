class SaleItem < ApplicationRecord
  belongs_to :sale
  belongs_to :product
  belongs_to :color
  belongs_to :dimension
  has_one :inventory_transaction,-> { where("changed_type=?", 1)},:foreign_key => 'source_id', dependent: :destroy
  validates :quantity, numericality: {less_than_or_equal_to: :getInventoryQty}

  private
  def getInventoryQty
    inventory = Inventory.getInventory(self.product_id, self.color_id, self.dimension_id).first
    quantity = inventory.quantity
    quantity
  end
end

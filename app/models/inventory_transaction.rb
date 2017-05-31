class InventoryTransaction < ApplicationRecord
  belongs_to :inventory
  belongs_to :purchase_item,-> { joins(:inventory_transaction).where("inventory_transactions.changed_type = ?", 0)}, :foreign_key => 'source_id'
  belongs_to :sale_item,-> { joins(:inventory_transaction).where("inventory_transactions.changed_type = ?", 1)}, :foreign_key => 'source_id'

  before_destroy :roll_back_original_cost_and_quantity_to_inventory
  enum changed_type: {
    purchase: 0,
    sale: 1,
  }

  def self.new_transaction_from_item(original_cost, original_quantity, change_cost, change_quantity, final_cost, final_quantity, change_type, source_id)
    transaction = self.new
    transaction.original_cost = original_cost
    transaction.original_quantity = original_quantity
    transaction.change_cost = change_cost
    transaction.change_quantity = change_quantity
    transaction.final_cost = final_cost
    transaction.final_quantity = final_quantity
    transaction.changed_type = change_type
    transaction.source_id = source_id
    transaction.save
  end

  private
  def roll_back_original_cost_and_quantity_to_inventory
    inventory_transaction = self
    @inventory = Inventory.find(inventory_transaction.inventory_id)
    if InventoryTransaction.where("inventory_id = ?", self.inventory_id).count == 1
      @inventory.destroy
    else
      @inventory.update(cost: inventory_transaction.original_cost,
                        quantity:inventory_transaction.original_quantity)
    end
  end
end

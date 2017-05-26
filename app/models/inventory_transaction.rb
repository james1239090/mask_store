class InventoryTransaction < ApplicationRecord
  belongs_to :inventory
  belongs_to :purchase_item,-> { joins(:inventory_transaction).where("inventory_transactions.changed_type = ?", 0)}, :foreign_key => 'source_id'

  enum changed_type: {
    purchase: 0,
    sale: 1,
  }

  def self.new_transaction_from_purchase_item(original_cost, original_quantity, change_cost, change_quantity, final_cost, final_quantity, change_type, source_id)
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
end

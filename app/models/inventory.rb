class Inventory < ApplicationRecord
  belongs_to :product
  belongs_to :dimension
  belongs_to :color
  has_many :inventory_transactions


  def self.add_inventory_from_purchase_item(purchase_item)
    inventory = self.new
    inventory.product_id = purchase_item.product_id
    inventory.dimension_id = purchase_item.dimension_id
    inventory.color_id = purchase_item.color_id
    inventory.cost = purchase_item.sub_total
    inventory.quantity = purchase_item.quantity
    inventory.save
    inventory.inventory_transactions.new_transaction_from_purchase_item(
      0,0,
      purchase_item.sub_total,purchase_item.quantity,
      purchase_item.sub_total,purchase_item.quantity,
    0,purchase_item.id)
  end

  def new_calculate_average_price(purchase_item)
    original_cost = self.cost
    original_quantity = self.quantity
    change_cost = purchase_item.sub_total
    change_quantity = purchase_item.quantity
    final_quantity = original_quantity+change_quantity
    final_cost = (original_cost*original_quantity+change_cost*change_quantity) / final_quantity

    self.inventory_transactions.new_transaction_from_purchase_item(
      original_cost,original_quantity,
      change_cost,change_quantity,
      final_cost,final_quantity,
    0, purchase_item.id)
    self.cost = final_cost
    self.quantity = final_quantity
    self.save
  end

  def update_calculate_avaerage_price(purchase_item)
    inventory_transaction = purchase_item.inventory_transaction

    original_cost = inventory_transaction.original_cost

    original_quantity = inventory_transaction.original_quantity
    puts "-------------original_quantity"
    puts original_quantity
    change_cost = purchase_item.sub_total
    change_quantity = purchase_item.quantity
    final_quantity = original_quantity+change_quantity
    final_cost = (original_cost*original_quantity+change_cost*change_quantity) / final_quantity

    inventory_transaction.update(original_cost: original_cost,
                                 original_quantity: original_quantity,
                                 change_cost: change_cost,
                                 change_quantity: change_quantity,
                                 final_cost: final_cost,
                                 final_quantity: final_quantity
                                 )
    self.cost = final_cost
    self.quantity = final_quantity
    self.save
  end
end

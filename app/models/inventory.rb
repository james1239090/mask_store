class Inventory < ApplicationRecord
  include Filterable
  belongs_to :product
  belongs_to :dimension
  belongs_to :color
  has_many :inventory_transactions

  scope :getInventory,-> (product, color, dimension) {
    where("product_id = ? and color_id = ? and dimension_id = ?", product, color, dimension)
  }

  scope :by_product_name,-> (name){
    joins(:product)
    .select("products.title as title, products.id as id")
    .where("products.title like ?", "%#{name}%")
  }

  scope :getColorOption, -> (product_id) {
    joins(:color)
    .select("color_id as id, colors.name as text")
    .where( :product_id => product_id )
    .group("colors.name","inventories.color_id")
  }
  scope :getDimensionOption,-> (product_id, color_id) {
    joins(:dimension)
    .select("dimension_id as id, dimensions.name as text")
    .where("product_id = ? and color_id = ?", product_id, color_id)
    .group("dimensions.name","inventories.dimension_id")
  }

  def self.add_inventory_from_purchase_item(purchase_item)
    inventory = self.new
    inventory.product_id = purchase_item.product_id
    inventory.dimension_id = purchase_item.dimension_id
    inventory.color_id = purchase_item.color_id
    inventory.cost = purchase_item.sub_total
    inventory.quantity = purchase_item.quantity
    inventory.save
    inventory.inventory_transactions.new_transaction_from_item(
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

    self.inventory_transactions.new_transaction_from_item(
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

  def sale_inventory_from_sale_item(sale_item)
    original_cost = self.cost
    original_quantity = self.quantity
    change_cost = self.cost
    change_quantity = sale_item.quantity
    final_quantity = original_quantity - change_quantity
    final_cost = self.cost
    self.quantity = final_quantity
    self.save
    self.inventory_transactions.new_transaction_from_item(
      original_cost,original_quantity,
      change_cost,change_quantity,
      final_cost,final_quantity,
    1, sale_item.id)
  end

  def update_sale_from_item(sale_item)
    inventory_transaction = sale_item.inventory_transaction

    original_cost = inventory_transaction.original_cost
    original_quantity = inventory_transaction.original_quantity
    change_cost = inventory_transaction.change_cost
    change_quantity = sale_item.quantity
    final_quantity = original_quantity - change_quantity
    final_cost = inventory_transaction.final_cost

    if inventory_transaction.update(original_cost: original_cost,
                                    original_quantity: original_quantity,
                                    change_cost: change_cost,
                                    change_quantity: change_quantity,
                                    final_cost: final_cost,
                                    final_quantity: final_quantity
                                    )

      self.cost = final_cost
      self.quantity = final_quantity
      self.save
    else
      puts "-----------------"
      puts "#{inventory_transaction.errors.messages}"
    end


  end
end

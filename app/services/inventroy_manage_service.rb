class InventroyManageService
  def initialize(purchase)
    @purchase = purchase
  end

  def purchase_new
    @purchase.purchase_items.each do |purchase_item|
      @inventory = Inventory.where('product_id = ? and dimension_id = ? and color_id = ?',
                                   purchase_item.product_id, purchase_item.dimension_id, purchase_item.color_id)
      if @inventory.blank?
        add_inventory_from_purchase_item(purchase_item)
      else
        @inventory_transaction = InventoryTransaction.new

      end
    end
  end


  private
  def add_inventory_from_purchase_item(purchase_item)
    @inventory = Inventory.new
    @inventory.product_id = purchase_item.product_id
    @inventory.dimension_id = purchase_item.dimension_id
    @inventory.color_id = purchase_item.color_id
    @inventory.cost = purchase_item.sub_total
    @inventory.quantity = purchase_item.quantity
    @inventory.save
  end
end

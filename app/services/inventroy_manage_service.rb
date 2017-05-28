class InventroyManageService
  def initialize(purchase)
    @purchase = purchase
  end

  def new_purchase!
    @purchase.purchase_items.each do |purchase_item|
      @inventory = Inventory.where('product_id = ? and dimension_id = ? and color_id = ?',
                                   purchase_item.product_id, purchase_item.dimension_id, purchase_item.color_id)
      if @inventory.blank?
        Inventory.add_inventory_from_purchase_item(purchase_item)
      else
        @inventory.first.new_calculate_average_price(purchase_item)
      end

    end
  end


  def update_purchase!
    @purchase.purchase_items.each do |purchase_item|
      @inventory = Inventory.where('product_id = ? and dimension_id = ? and color_id = ?',
                                   purchase_item.product_id, purchase_item.dimension_id, purchase_item.color_id)
      @inventory.first.update_calculate_avaerage_price(purchase_item)
    end
  end


end

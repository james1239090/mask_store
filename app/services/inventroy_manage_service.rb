class InventroyManageService
  def initialize(source)
    @source = source
  end

  def new_purchase!
    @source.purchase_items.each do |purchase_item|
      @inventory = Inventory.getInventory(purchase_item.product_id,purchase_item.color_id , purchase_item.dimension_id)
      puts Inventory.getInventory(purchase_item.product_id,purchase_item.color_id ,  purchase_item.dimension_id)

      if @inventory.count == 0
        Inventory.add_inventory_from_purchase_item(purchase_item)
      else
        @inventory.first.new_calculate_average_price(purchase_item)
      end

    end
  end


  def update_purchase!
    @source.purchase_items.each do |purchase_item|
      @inventory = Inventory.getInventory(purchase_item.product_id, purchase_item.dimension_id, purchase_item.color_id)
      @inventory.first.update_calculate_avaerage_price(purchase_item)
    end
  end

  def new_sale!
    @source.sale_items.each do |sale_item|
      @inventory = Inventory.getInventory(sale_item.product_id, sale_item.color_id, sale_item.dimension_id).first
      @inventory.sale_inventory_from_sale_item(sale_item)
    end
  end

  def update_sale!
    @source.sale_items.each do |sale_item|
      @inventory = Inventory.getInventory(sale_item.product_id, sale_item.color_id, sale_item.dimension_id).first
      @inventory.update_sale_from_item(sale_item)
    end
  end

end

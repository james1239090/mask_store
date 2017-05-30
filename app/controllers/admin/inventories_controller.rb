class Admin::InventoriesController < AdminController
  def index
    @inventories = Inventory.all
  end

  def show
    @inventory = Inventory.find(params[:id])
    @transactions = @inventory.inventory_transactions.order("id")
  end
end

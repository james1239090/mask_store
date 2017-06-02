class Admin::InventoriesController < AdminController
  def index
    @inventories = Inventory.filter(params.slice(:by_product_name,:p_id, :c_id,:getFromProAndCol,:g_id))
    respond_to do |format|
      format.html
      format.json do
        render json: @inventories
      end
    end
  end

  def show
    @inventory = Inventory.find(params[:id])
    @transactions = @inventory.inventory_transactions.order("id")
  end
end

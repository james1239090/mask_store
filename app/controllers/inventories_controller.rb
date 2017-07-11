class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.filter(params.slice(:by_product_name,:getColorOption,:getDimensionOption,:getInventory))
    respond_to do |format|
      format.html
      format.json do
        render json: @inventories
      end
    end
  end
end

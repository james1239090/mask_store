class Admin::SalesController < AdminController
  before_action :find_sale , only: [:show, :edit, :update, :destroy]

  def index
    @sales = Sale.all


    gon.ship_type_count = @sales.getShipTypeCount
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)

    if @sale.save
      @sale.calculate_each_item_fee!
      @sale.calculate_each_total_fee!
      InventroyManageService.new(@sale).new_sale!
      redirect_to admin_sales_path
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @sale.update(sale_params)
      @sale.calculate_each_item_fee!
      @sale.calculate_each_total_fee!
      InventroyManageService.new(@sale).update_sale!
      redirect_to admin_sales_path
    else
      render :edit
    end
  end

  def destroy
    @sale.destroy

    redirect_to admin_sales_path
  end

  def show
    @sale_items = @sale.sale_items
  end

  private
  def find_sale
    @sale = Sale.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:order_number, :city_id,:district_id, :ship_type_id, :sale_date, :shipping_date, :sale_platform_id, :address, :shipping_number,
                                 sale_items_attributes:[:id, :product_id, :dimension_id, :color_id, :cost, :quantity, :sale_price, :shipping_fee, :_destroy]
                                 )
  end

end

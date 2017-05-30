class Admin::SalesController < AdminController

  def index
    @sales = Sale.all
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

  end

  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy

    redirect_to admin_sales_path
  end


  private

  def sale_params
    params.require(:sale).permit(:order_number, :city_id,:district_id, :ship_type_id, :sale_date, :shipping_date, :sale_platform_id, :address, :shipping_number,
                                 sale_items_attributes:[:id, :product_id, :dimension_id, :color_id, :cost, :quantity, :sale_price, :shipping_fee, :_destroy]
                                 )
  end

end

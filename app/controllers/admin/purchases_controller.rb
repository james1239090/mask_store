class Admin::PurchasesController < AdminController
  before_action :find_purchase, only: [:edit,:update,:destroy,:show]
  def index
    @purchases = Purchase.all
    gon.purchases = @purchases.order("id")
  end

  def new
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(purchase_params)
    if @purchase.save
      @purchase.total_currency!
      @purchase.calculate_currency_rate!
      @purchase.calculate_tw_total_shipping_fee!
      @purchase.calculate_each_tw_price!
      @purchase.calculate_each_fee!
      @purchase.caculate_round_diff!

      InventroyManageService.new(@purchase).new_purchase!
      redirect_to admin_purchases_path
    else
      puts "-------------"
      puts "#{@purchase.errors.full_messages}"
      render :new
    end

  end

  def edit

  end

  def update
    if @purchase.update(purchase_params)
      @purchase.total_currency!
      @purchase.calculate_currency_rate!
      @purchase.calculate_tw_total_shipping_fee!
      @purchase.calculate_each_tw_price!
      @purchase.calculate_each_fee!
      @purchase.caculate_round_diff!

      InventroyManageService.new(@purchase).update_purchase!
      redirect_to admin_purchases_path
    else
      puts "-------------"
      puts "#{@purchase.errors.full_messages}"
      render :edit
    end
  end

  def show
    @purchase_items = @purchase.purchase_items
  end

  def destroy
    @purchase.destroy
    redirect_to admin_purchases_path
  end

  private
  def purchase_params
    params.require(:purchase).permit(:total_currency_price, :total_tw_price, :total_tw_duty, :total_currency_shipping_fee,
                                     :total_tw_service_fee, :purchase_date, :delivery_date,
                                     purchase_items_attributes:[:id,:product_id,:color_id,:dimension_id,:quantity,:currency_price,:tw_price,
                                                                :duty,:shipping_fee,:service_fee,:_destroy])
  end

  def find_purchase
    @purchase = Purchase.find(params[:id])
  end
end

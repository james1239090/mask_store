class Admin::PurchasesController < AdminController

  def index
    @purchases = Purchase.all
  end

  def new
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(purchase_params)

    if @purchase.save
      redirect_to admin_purchases_path
    else
      puts "-------------"
      puts "#{@purchase.errors.full_messages}"
      render :new
    end

  end

  def edit
    @purchase = Purchase.find(params[:id])
  end

  def update
    @purchase = Purchase.find(params[:id])

    if @purchase.update(purchase_params)
      redirect_to admin_purchases_path
    else
      puts "-------------"
      puts "#{@purchase.errors.full_messages}"
      render :edit
    end
  end


  private
  def purchase_params
    params.require(:purchase).permit(:total_currency_price, :total_tw_price, :total_duty, :total_shipping_fee,
                                     :total_service_fee, :purchase_date, :delivery_date,
                                     purchase_items_attributes:[:id,:product_id,:color_id,:dimension_id,:quantity,:currency_price,:tw_price,
                                                                :duty,:shipping_fee,:service_fee,:_destroy])
  end
end

class Admin::PurchasesController < AdminController

  def index
    @purchases = Purchase.all
  end

  def new
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(purchase_params)
  end


  private
  def purchase_params
    params.require(:purchase).permit(:total_currency_price, :total_tw_price, :total_duty, :total_shipping_fee,
                                     :total_service_fee, :purchase_date, :delivery_date,
                                     purchase_items_attributes:[:size,:color,:quantity,:currency_price,:tw_price,
                                                                 :duty,:shipping_fee,:service_fee])
  end
end

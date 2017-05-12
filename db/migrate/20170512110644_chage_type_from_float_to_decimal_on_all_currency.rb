class ChageTypeFromFloatToDecimalOnAllCurrency < ActiveRecord::Migration[5.0]
  def change
    change_column :purchase_items, :currency_price, :decimal,:precision => 8, :scale => 2
    change_column :purchase_items, :tw_price, :decimal,:precision => 8, :scale => 2
    change_column :purchase_items, :duty, :decimal,:precision => 8, :scale => 2
    change_column :purchase_items, :shipping_fee, :decimal,:precision => 8, :scale => 2
    change_column :purchase_items, :service_fee, :decimal,:precision => 8, :scale => 2
    change_column :purchases, :total_currency_price, :decimal,:precision => 8, :scale => 2
    change_column :purchases, :total_tw_price, :decimal,:precision => 8, :scale => 2
    change_column :purchases, :total_duty, :decimal,:precision => 8, :scale => 2
    change_column :purchases, :total_service_fee, :decimal,:precision => 8, :scale => 2
    change_column :purchases, :currency_rate, :decimal,:precision => 8, :scale => 4
    change_column :purchases, :total_tw_shipping_fee, :decimal,:precision => 8, :scale => 2
    change_column :purchases, :total_currency_shipping_fee, :decimal,:precision => 8, :scale => 2
  end
end

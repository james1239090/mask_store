class AddTwShippingAndRenameCurrencyShipping < ActiveRecord::Migration[5.0]
  def change
    change_column :purchases, :total_shipping_fee, :total_currency_shipping_fee
    add_column :purchases, :total_tw_shipping_fee, :float
  end
end

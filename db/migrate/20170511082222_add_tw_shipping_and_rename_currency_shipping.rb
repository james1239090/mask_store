class AddTwShippingAndRenameCurrencyShipping < ActiveRecord::Migration[5.0]
  def change
    add_column :purchases, :total_tw_shipping_fee, :float
  end
end

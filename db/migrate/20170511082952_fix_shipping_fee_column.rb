class FixShippingFeeColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :purchases, :total_shipping_fee
    add_column :purchases, :total_currency_shipping_fee, :float
  end
end

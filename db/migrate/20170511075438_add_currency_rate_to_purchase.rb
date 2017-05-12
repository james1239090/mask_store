class AddCurrencyRateToPurchase < ActiveRecord::Migration[5.0]
  def change
    add_column :purchases, :currency_rate, :float
  end
end

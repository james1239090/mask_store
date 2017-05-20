class ChagnedPurchasePriceBackToDecimal < ActiveRecord::Migration[5.0]
  def change
    change_column :purchase_items, :sub_total , :decimal,:precision => 8, :scale => 2
    change_column :purchase_items, :total , :decimal,:precision => 8, :scale => 2
  end
end

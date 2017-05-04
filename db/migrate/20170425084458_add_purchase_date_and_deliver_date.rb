class AddPurchaseDateAndDeliverDate < ActiveRecord::Migration[5.0]
  def change
    add_column :purchases, :purchase_date, :datetime
    add_column :purchases, :delivery_date, :datetime
  end
end

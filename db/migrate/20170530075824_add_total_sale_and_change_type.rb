class AddTotalSaleAndChangeType < ActiveRecord::Migration[5.0]
  def change
    add_column :sales, :total_sale, :integer
    rename_column :sales, :shipping_fee, :total_shipping_fee
    change_column :sale_items, :service_fee, 'integer USING CAST(service_fee AS integer)', default: 0
  end
end

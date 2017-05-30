class AddSubTotalAndChangeTypeOnSaleItems < ActiveRecord::Migration[5.0]
  def change
    change_column :sale_items, :cost , :decimal
    change_column :sale_items, :profit , :decimal
    change_column :sale_items, :profit_rate , :decimal
    change_column :sale_items, :shipping_fee , :integer, default: 0
    change_column :sale_items, :credit_fee , :integer, default: 0
    add_column :sale_items, :cost_sub_total, :decimal
    add_column :sale_items, :sale_sub_total, :integer
  end
end

class ChangeCartItemsTableColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :cart_items, :product_it, :product_id
  end
end

class RenameInventoryTransactionColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :inventory_transactions, :chagne_quantity, :change_quantity
  end
end

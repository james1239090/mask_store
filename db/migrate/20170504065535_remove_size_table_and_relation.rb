class RemoveSizeTableAndRelation < ActiveRecord::Migration[5.0]
  def change
    drop_table :sizes
    rename_column :purchase_items, :size, :dimension
  end
end

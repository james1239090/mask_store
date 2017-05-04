class RemoveSizeTableAndRelation < ActiveRecord::Migration[5.0]
  def change
    rename_column :purchase_items, :size, :dimension
  end
end

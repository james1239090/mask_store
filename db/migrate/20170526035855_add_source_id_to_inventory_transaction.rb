class AddSourceIdToInventoryTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :inventory_transactions, :source_id, :integer
  end
end

class AddSubTotalAndTotalColumnOnPurchaseItems < ActiveRecord::Migration[5.0]
  def change
    add_column :purchase_items, :sub_total, :integer
    add_column :purchase_items, :total, :integer
  end
end

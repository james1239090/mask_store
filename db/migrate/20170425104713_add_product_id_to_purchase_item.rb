class AddProductIdToPurchaseItem < ActiveRecord::Migration[5.0]
  def change
    add_column :purchase_items, :product_id , :integer
  end
end

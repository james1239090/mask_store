class AddShippingNumberOnSale < ActiveRecord::Migration[5.0]
  def change
    add_column :sales, :shipping_number, :string
  end
end

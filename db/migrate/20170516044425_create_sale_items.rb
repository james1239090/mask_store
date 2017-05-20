class CreateSaleItems < ActiveRecord::Migration[5.0]
  def change
    create_table :sale_items do |t|
      t.integer :sale_id
      t.integer :product_id
      t.integer :dimension_id
      t.integer :color_id
      t.integer :cost
      t.integer :quantity
      t.integer :sale_price
      t.integer :shipping_fee
      t.integer :service_fee
      t.integer :credit_fee
      t.integer :profit
      t.integer :profit_rate
      t.timestamps
    end
  end
end

class CreateSales < ActiveRecord::Migration[5.0]
  def change
    create_table :sales do |t|
      t.string :order_number
      t.integer :city_id
      t.integer :district_id
      t.string  :address
      t.integer :sale_platform_id
      t.integer :ship_type_id
      t.integer :total_cost
      t.integer :shipping_fee
      t.integer :total_service_fee
      t.integer :total_profit
      t.decimal :total_profit_rate
      t.datetime :sale_date
      t.datetime :shipping_date
      t.timestamps
    end
  end
end

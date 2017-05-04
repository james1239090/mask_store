class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.float 'total_currency_price'
      t.float 'total_tw_price'
      t.float 'total_duty'
      t.float 'total_shipping_fee'
      t.float 'total_service_fee'
      t.timestamps
    end
  end
end

class CreatePurchaseItems < ActiveRecord::Migration[5.0]
  def change
    create_table :purchase_items do |t|
      t.integer 'purchase_id'
      t.string 'size'
      t.string 'color'
      t.integer 'quantity'
      t.float 'currency_price'
      t.float 'tw_price'
      t.float 'duty'
      t.float 'shipping_fee'
      t.float 'service_fee'
      t.timestamps
    end
  end
end

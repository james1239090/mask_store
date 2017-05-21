class CreateInventoryTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :inventory_transactions do |t|
      t.integer  "inventory_id"
      t.decimal  "original_cost",     precision: 8, scale: 2
      t.integer  "original_quantity"
      t.decimal  "change_cost",       precision: 8, scale: 2
      t.integer  "chagne_quantity"
      t.decimal  "final_cost",        precision: 8, scale: 2
      t.integer  "final_quantity"
      t.integer  "changed_type"
      t.timestamps
    end
  end
end

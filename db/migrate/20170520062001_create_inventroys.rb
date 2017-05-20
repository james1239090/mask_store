class CreateInventroys < ActiveRecord::Migration[5.0]
  def change
    create_table :inventroys do |t|
      t.integer :product_id
      t.integer :color_id
      t.integer :dimension_id
      t.decimal :cost,        precision: 8, scale: 2
      t.integer :quantity
      t.timestamps
    end
  end
end

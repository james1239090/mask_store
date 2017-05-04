class CreateProductOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :product_options do |t|
      t.integer :product_id
      t.integer :dimension_id
      t.integer :color_id

      t.timestamps
    end
  end
end

class AddColorDimensionIdToCartItem < ActiveRecord::Migration[5.0]
  def change
    add_column :cart_items, :color_id, :integer
    add_column :cart_items, :dimension_id, :integer
  end
end

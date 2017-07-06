class AddColorDimensionToOrderItem < ActiveRecord::Migration[5.0]
  def change
    add_column :order_items, :color_name, :string
    add_column :order_items, :dimension_name, :string
  end
end

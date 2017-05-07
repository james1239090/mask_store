class ChangeColorAndDimensionType < ActiveRecord::Migration[5.0]
  def change
    rename_column :purchase_items, :color, :color_id
    rename_column :purchase_items, :dimension, :dimension_id

    change_column :purchase_items, :color_id, :integer
    change_column :purchase_items, :dimension_id, :integer

  end
end

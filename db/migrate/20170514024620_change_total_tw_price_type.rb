class ChangeTotalTwPriceType < ActiveRecord::Migration[5.0]
  def change
    change_column :purchases, :total_tw_price, 'integer USING CAST(total_tw_price AS integer)'
    change_column :purchases, :total_duty, 'integer USING CAST(total_duty AS integer)'
    change_column :purchases, :total_service_fee, 'integer USING CAST(total_service_fee AS integer)'
    rename_column :purchases, :total_duty, :total_tw_duty
    rename_column :purchases, :total_service_fee, :total_tw_service_fee
  end
end

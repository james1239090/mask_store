class AddColumnToStoreAfterRoundDiff < ActiveRecord::Migration[5.0]
  def change
    add_column :purchases, :round_diff_money, :integer
  end
end

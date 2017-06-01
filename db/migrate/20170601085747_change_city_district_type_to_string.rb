class ChangeCityDistrictTypeToString < ActiveRecord::Migration[5.0]
  def change
    change_column :sales, :city_id, :string
    change_column :sales, :district_id, :string
  end
end

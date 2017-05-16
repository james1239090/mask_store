class CreateSalePlatforms < ActiveRecord::Migration[5.0]
  def change
    create_table :sale_platforms do |t|
      t.decimal :service_rate
      t.string :name

      t.timestamps
    end
  end
end

class ReNameImageToImagesOnPhoto < ActiveRecord::Migration[5.0]
  def change
    rename_column :photos, :image, :images
  end
end

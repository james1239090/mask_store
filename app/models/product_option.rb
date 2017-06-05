class ProductOption < ApplicationRecord
  include Filterable
  belongs_to :product, optional: true
  belongs_to :dimension
  belongs_to :color

  accepts_nested_attributes_for :dimension, :reject_if => :all_blank
  accepts_nested_attributes_for :color, :reject_if => :all_blank
  scope :getColorOption, -> (product_id) {
    joins(:color)
    .select("color_id as id, colors.name as text")
    .where( :product_id => product_id )
    .group("colors.name","product_options.color_id")
  }
  scope :getDimensionOption,-> (product_id, color_id) {
    joins(:dimension)
    .select("dimension_id as id, dimensions.name as text")
    .where("product_id = ? and color_id = ?",product_id, color_id)
    .group("dimensions.name","product_options.dimension_id")
  }

end

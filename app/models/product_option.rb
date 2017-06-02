class ProductOption < ApplicationRecord
  include Filterable
  belongs_to :product, optional: true
  belongs_to :dimension
  belongs_to :color

  accepts_nested_attributes_for :dimension, :reject_if => :all_blank
  accepts_nested_attributes_for :color, :reject_if => :all_blank
  scope :p_id, -> (id) {
    joins(:color)
    .select("color_id as id, colors.name as text")
    .where( :product_id => id )
  }
  scope :getFromProAndCol,-> (p_id,c_id) {
    joins(:dimension)
    .select("dimension_id as id, dimensions.name as text")
    .where("product_id = ? and color_id = ?",p_id,c_id)
  }
  scope :g_id, -> (id) { group(id)}

end

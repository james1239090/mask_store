class ProductOption < ApplicationRecord
  include Filterable
  belongs_to :product, optional: true
  belongs_to :dimension
  belongs_to :color

  accepts_nested_attributes_for :dimension, :reject_if => :all_blank
  accepts_nested_attributes_for :color, :reject_if => :all_blank
  scope :p_id, -> (id) { where( :product_id => "#{id}" )}
  scope :c_id, -> (id) { where( :color_id => "#{id}" )}
  scope :g_id, -> (id) { group("#{id}")}
  scope :by_color,  -> (id) {
    joins(:color)
    .select('color_id as id,colors.name')
    .where(:product_id => id)
    .group(:color_id)
  }

  scope :by_dimension,  -> (id) {
    joins(:dimension)
    .select('dimension_id as id,dimensions.name')
    .where(:product_id => id)
    .group(:dimension_id)
  }

end

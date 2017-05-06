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
end

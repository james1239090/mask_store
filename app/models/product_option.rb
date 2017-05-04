class ProductOption < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :dimension
  belongs_to :color

  accepts_nested_attributes_for :dimension, :reject_if => :all_blank
  accepts_nested_attributes_for :color, :reject_if => :all_blank
end

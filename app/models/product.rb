class Product < ApplicationRecord
  has_one :photo
  has_many :product_options, dependent: :destroy
  has_many :dimensions, :through => :product_options, source: :dimension
  has_many :colors, :through => :product_options, source: :color

  accepts_nested_attributes_for :photo, :allow_destroy => true
  accepts_nested_attributes_for :product_options, :allow_destroy => true
  accepts_nested_attributes_for :dimensions, :allow_destroy => true
  accepts_nested_attributes_for :colors, :allow_destroy => true
end

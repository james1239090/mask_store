class Product < ApplicationRecord
 has_one :photo
 has_many :sizes, inverse_of: :product

 accepts_nested_attributes_for :photo, :allow_destroy => true
 accepts_nested_attributes_for :sizes, reject_if: :all_blank, :allow_destroy => true

end

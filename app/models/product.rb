class Product < ApplicationRecord
 has_one :photo

 accepts_nested_attributes_for :photo,:allow_destroy => true

end

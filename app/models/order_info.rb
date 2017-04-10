class OrderInfo < ApplicationRecord
  belongs_to :order, optional: true
end

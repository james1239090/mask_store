class OrderInfo < ApplicationRecord
  belongs_to :order, optional: true

  validates :billing_name, presence: true
  validates :billing_address, presence: true
  validates :shipping_name, presence: true
  validates :shipping_address, presence: true
end

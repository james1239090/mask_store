class Inventory < ApplicationRecord
  belongs_to :product
  belongs_to :dimension
  belongs_to :color
  has_many :inventory_transactions
end

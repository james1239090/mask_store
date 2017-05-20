class Inventroy < ApplicationRecord
  belongs_to :product
  belongs_to :dimension
  belongs_to :color
  has_many :inventroy_transactions
end

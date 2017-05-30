class SaleItem < ApplicationRecord
  belongs_to :purchase
  belongs_to :product
  belongs_to :color
  belongs_to :dimension
  has_one :inventory_transaction,-> { where("changed_type=?", 1)},:foreign_key => 'source_id', dependent: :destroy


end

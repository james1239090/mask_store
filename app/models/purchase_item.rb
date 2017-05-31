class PurchaseItem < ApplicationRecord
  belongs_to :purchase
  belongs_to :product
  belongs_to :color
  belongs_to :dimension
  has_one :inventory_transaction,-> { where("changed_type=?", 0)},:foreign_key => 'source_id', dependent: :destroy

  monetize :currency_price, :as=> "currency"
  validates :product_id, :dimension_id,:color_id, :quantity, :currency_price, presence: true

  # monetize :sub_total, :as=> "sub_cents" , :with_currency => :twd
  # monetize :total, :as=> "total_cents" , :with_currency => :twd
end

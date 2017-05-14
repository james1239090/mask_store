class PurchaseItem < ApplicationRecord
  belongs_to :purchase
  belongs_to :product
  belongs_to :color
  belongs_to :dimension

  monetize :currency_price, :as=> "currency"

end
class PurchaseItem < ApplicationRecord
  belongs_to :purchase
  belongs_to :product
  belongs_to :color
  belongs_to :dimension

  monetize :currency_price, :as=> "currency"
  # monetize :sub_total, :as=> "sub_cents" , :with_currency => :twd
  # monetize :total, :as=> "total_cents" , :with_currency => :twd
end

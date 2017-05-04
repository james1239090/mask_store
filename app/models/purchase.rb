class Purchase < ApplicationRecord
  has_many :purchase_items, dependent: :destroy,inverse_of: :purchase
  has_many :items, through: :purchase_items, source: :product


  accepts_nested_attributes_for :purchase_items, reject_if: :all_blank, :allow_destroy => true
end

class Purchase < ApplicationRecord
  has_many :purchase_items, dependent: :destroy
  has_many :items, through: :purchase_items, source: :product

  accepts_nested_attributes_for :purchase_items, reject_if: :all_blank, :allow_destroy => true

  def total_currency!
    sum = 0
    purchase_items.each do |purchase_item|
      sum = sum + (purchase_item.currency_price * purchase_item.quantity)
    end
    self.total_currency_price = sum + self.total_currency_shipping_fee
    self.save
  end

  def calculate_currency_rate!
    rate = self.total_tw_price / self.total_currency_price
    self.currency_rate = rate
    self.save
  end

  def calculate_each_tw_price!
    purchase_items.each do |purchase_item|
      purchase_item.tw_price = purchase_item.currency_price * self.currency_rate
      purchase_item.save
    end
  end

  def calculate_tw_total_shipping_fee!
    self.total_tw_shipping_fee = self.total_currency_shipping_fee * self.currency_rate
    self.save
  end

  def calculate_each_fee!
    purchase_items.each do |purchase_item|
      purchase_item.duty = (purchase_item.currency_price * self.total_duty) / self.total_currency_price
      purchase_item.shipping_fee = (purchase_item.currency_price * self.total_tw_shipping_fee) / self.total_currency_price
      purchase_item.service_fee = purchase_item.currency_price * self.total_service_fee / self.total_currency_price
      purchase_item.save
    end
  end

end

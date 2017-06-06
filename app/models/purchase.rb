class Purchase < ApplicationRecord
  has_many :purchase_items, dependent: :destroy
  has_many :items, through: :purchase_items, source: :product
  validates :total_tw_price, :total_tw_duty ,:total_tw_service_fee, :total_currency_shipping_fee, :purchase_items, presence: true

  accepts_nested_attributes_for :purchase_items, reject_if: :all_blank, :allow_destroy => true
  monetize :total_tw_price, :as=> "total_tw_cents" , :with_currency => :twd

  def total_currency!
    sum = 0
    purchase_items.each do |purchase_item|
      sum = sum + (purchase_item.currency_price * purchase_item.quantity)
    end
    self.total_currency_price = (sum + self.total_currency_shipping_fee).round(2)
    self.save
  end

  def calculate_currency_rate!
    rate = self.total_tw_price / self.total_currency_price
    self.currency_rate = rate.round(4)
    self.save
  end

  def calculate_each_tw_price!
    purchase_items.each do |purchase_item|
      purchase_item.tw_price = (purchase_item.currency_price * self.currency_rate).round(2)
      purchase_item.save
    end
  end

  def calculate_tw_total_shipping_fee!
    self.total_tw_shipping_fee = (self.total_currency_shipping_fee * self.currency_rate).round(2)
    self.save
  end

  def calculate_each_fee!
    total_currency = self.total_currency_price - self.total_currency_shipping_fee
    duty = self.total_tw_duty
    tw_shipping = self.total_tw_shipping_fee
    service_fee = self.total_tw_service_fee

    purchase_items.each do |purchase_item|
      purchase_item.duty = ((purchase_item.currency_price * duty) / total_currency).round(2)
      purchase_item.shipping_fee = ((purchase_item.currency_price * tw_shipping) / total_currency).round(2)
      purchase_item.service_fee = (purchase_item.currency_price *  service_fee / total_currency).round(2)
      purchase_item.sub_total = purchase_item.tw_price + purchase_item.duty +  purchase_item.shipping_fee + purchase_item.service_fee
      purchase_item.total = (purchase_item.sub_total * purchase_item.quantity).round(2)
      purchase_item.sub_total = purchase_item.sub_total.round(2)
      purchase_item.save
    end
  end

  def caculate_round_diff!
    total = 0
    purchase_items.each do |purchase_item|
      total = total +  purchase_item.total
    end
    self.round_diff_money = self.total_tw_price + self.total_tw_duty + self.total_tw_service_fee - total
    self.save
  end

end

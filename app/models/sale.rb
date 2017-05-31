class Sale < ApplicationRecord
  belongs_to :sale_platform
  has_many :sale_items, dependent: :destroy
  accepts_nested_attributes_for :sale_items, reject_if: :all_blank, :allow_destroy => true
  validates :sale_platform_id, :ship_type_id,:city_id, :district_id, :order_number, presence: true

  enum ship_type_id: {
    "7-11": "0",
    "familyport": "1",
    "宅配": "2",
    "郵寄": "3"
  }

  def calculate_each_item_fee!
    service_rate = self.sale_platform.service_rate / 100

    sale_items.each do |item|
      cost = Inventory.getInventory(item.product_id, item.color_id, item.dimension_id).first.cost
      item.cost = cost
      item.service_fee = item.sale_price * service_rate
      item.cost_sub_total = item.quantity * item.cost
      item.sale_sub_total = item.quantity * item.sale_price
      item.profit =  item.sale_sub_total - item.cost_sub_total - item.service_fee - item.shipping_fee - item.credit_fee
      item.profit_rate = item.profit / item.sale_sub_total
      item.save
    end

  end

  def calculate_each_total_fee!
    total_cost = 0
    total_shipping_fee = 0
    total_service_fee = 0
    total_profit = 0
    total_sale = 0
    sale_items.each do |item|
      total_cost = total_cost + item.cost_sub_total
      total_shipping_fee = total_service_fee + item.shipping_fee
      total_service_fee = total_service_fee + item.service_fee
      total_profit = total_profit + item.profit
      total_sale = total_sale + item.sale_sub_total
    end
    self.total_cost = total_cost
    self.total_shipping_fee = total_shipping_fee
    self.total_service_fee = total_service_fee
    self.total_profit = total_profit
    self.total_sale = total_sale
    self.total_profit_rate = total_profit / total_sale
    self.save
  end


end

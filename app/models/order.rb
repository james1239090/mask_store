class Order < ApplicationRecord
  belongs_to :user
  has_many :item, class_name: "OrderItem", dependent: :destroy
  has_one :info, class_name: "OrderInfo", dependent: :destroy

  accepts_nested_attributes_for :info

end

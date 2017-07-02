class Product < ApplicationRecord
  include Filterable
  validates :title,:price ,presence: true
  has_one :photo, dependent: :destroy
  has_many :product_options, dependent: :destroy
  has_many :dimensions, :through => :product_options, source: :dimension
  has_many :colors, :through => :product_options, source: :color
  has_many :inventories

  accepts_nested_attributes_for :photo, :allow_destroy => true
  accepts_nested_attributes_for :product_options, :allow_destroy => true,:reject_if => :all_blank
  accepts_nested_attributes_for :dimensions, :allow_destroy => true
  accepts_nested_attributes_for :colors, :allow_destroy => true

  scope :q_name,  -> (name) { where "title like ?", "%#{name}%"}
  scope :get_inventory,-> (qty) {
    joins(:inventories)
    .select("products.id, products.title")
    .where("inventories.quantity > ?",qty).group("products.id")
  }
  scope :q_name_with_inven, -> (name) {
    joins(:inventories)
    .select("products.id, products.title")
    .where("title like ? and inventories.quantity > 0","%#{name}%").group("products.id")
  }
end

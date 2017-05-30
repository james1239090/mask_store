class Sale < ApplicationRecord
  belongs_to :sale_platform_id

  enum ship_type_id: {
    "7-11": 0,
    "familyport": 1,
    "宅配": 2,
    "郵寄":3
  }



end

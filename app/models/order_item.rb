class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates_presence_of :item_name,
                        :merchant_name,
                        :price,
                        :quantity,
                        :sub_total
end

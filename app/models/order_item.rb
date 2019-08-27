class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates_presence_of    :price,
                        :quantity,
                        :sub_total
end

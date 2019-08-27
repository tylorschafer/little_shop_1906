class Merchant <ApplicationRecord
  has_many :items, dependent: :destroy

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def has_order
    items.joins(:order_items).count(:id) >= 1
  end

  def items_count
    items.count
  end

  def average_item_price
    items.average(:price)
  end

  def distinct_cities
    items.joins(:orders)
      .distinct
      .order('orders.city')
      .pluck('orders.city')
  end
end

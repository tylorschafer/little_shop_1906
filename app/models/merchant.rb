class Merchant <ApplicationRecord
  has_many :items, dependent: :destroy

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def has_order
    Item.joins(:order_items).where(merchant_id: self.id).count(:id) >= 1
  end

  def items_count
    Item.where(merchant_id: self.id).count(:id)
  end

  def average_item_price
    Item.where(merchant_id: self.id).average(:price)
  end
end

class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :order_items
  has_many :orders, through: :order_items

  validates_presence_of :name,
                        :description,
                        :price,
                        :image,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]

  def update_inventory
    order_item = OrderItem.last
    self.inventory -= order_item.quantity unless order_item.item_id != self.id
    if self.inventory <= 0
      self.update_attribute(:active?, false)
    end
  end

  def has_order
    OrderItem.where(item_id: self.id.to_s).count(:item_id) > 0
  end
end

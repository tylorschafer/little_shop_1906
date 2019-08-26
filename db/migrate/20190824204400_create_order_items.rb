class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.references :item, foreign_key: true
      t.references :order, foreign_key: true
      t.string :item_name
      t.string :merchant_name
      t.integer :price
      t.integer :quantity
      t.integer :sub_total
    end
  end
end

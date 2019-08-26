require 'rails_helper'

describe OrderItem do

  describe 'Relationships' do
    it {should belong_to :order}
    it {should belong_to :item}
  end

  describe 'Valadations' do
    it {should validate_presence_of :item_name}
    it {should validate_presence_of :merchant_name}
    it {should validate_presence_of :price}
    it {should validate_presence_of :quantity}
    it {should validate_presence_of :sub_total}
  end
end

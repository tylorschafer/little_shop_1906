require 'rails_helper'

describe Order do
  describe 'relationships' do
    it { should have_many :order_items}
    it { should have_many(:items).through(:order_items)}
  end
end

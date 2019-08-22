require 'rails_helper'

describe Cart do
  before :each do
    @cart = Cart.new({
        1 => 2,
        2 => 3
      })
  end
  describe "instance methods" do
    it "#total_count can calculate total number of items in the cart." do
      expect(@cart.total_count).to eq(5)
    end
  end
end

require 'rails_helper'

describe Cart do
  before :each do
    @cart = Cart.new({
        '1' => 19,
        '2' => 18
      })
  end
  describe "instance methods" do
    it "#total_count can calculate total number of items in the cart" do
      expect(@cart.total_count).to eq(37)
    end
    describe "#add_item" do
      it "adds an item to cart contents" do
        @cart.add_item(1)
        @cart.add_item(2)

        expect(@cart.contents).to eq({'1' => 20, '2' => 19})
      end
      it "adding an item out of inital contents is still added" do
        @cart.add_item('4')

        expect(@cart.contents).to eq({'1' => 19, '2' => 18, '4' => 1})
      end
    end
    it "#count_of returns the total count quantity of that item " do
      expect(@cart.count_of(5)).to eq(0)
      expect(@cart.count_of(1)).to eq(19)
    end
  end
end

require 'rails_helper'

describe Cart do
  describe "Instance methods" do
    before :each do
      @merchant = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @item_1 = @merchant.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 20)
      @item_2 = @merchant.items.create(name: "Raptorskins", description: "This is different", price: 80, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 19)
      @cart = Cart.new({
          "#{@item_1.id}" => 19,
          "#{@item_2.id}" => 18
         })
    end

    it "#invanlid_item? will return true if that item is no longer in database" do
      expect(@cart.invalid_item?(@item_1.id)).to eq(false)
      @item_1.destroy
      expect(@cart.invalid_item?(@item_1.id)).to eq(true)
    end

    it "#total_count can calculate total number of items in the cart" do
      expect(@cart.total_count).to eq(37)
    end

    describe "#add_item" do
      it "adds an item to cart contents" do
        @cart.add_item(@item_1.id)
        @cart.add_item(@item_2.id)

        expect(@cart.contents).to eq({"#{@item_1.id}" => 20, "#{@item_2.id}" => 19})
      end
      it "adding an item out of inital contents is still added" do
        @cart.add_item('4')

        expect(@cart.contents).to eq({"#{@item_1.id}" => 19, "#{@item_2.id}" => 18, '4' => 1})
      end
    end

    it "#subtract_item removes a single quantity of an item from cart contents" do
      @cart.subtract_item(@item_1.id)
      @cart.subtract_item(@item_2.id)

      expect(@cart.contents).to eq({"#{@item_1.id}" => 18, "#{@item_2.id}" => 17})
    end

    it "#remove_item removes an item and its quantity from cart" do
        @cart.add_item('4')

        @cart.remove_item('4')

        expect(@cart.contents).to eq({"#{@item_1.id}" => 19, "#{@item_2.id}" => 18})
    end

    it "#count_of returns the total count quantity of that item " do
      expect(@cart.count_of(5)).to eq(0)
      expect(@cart.count_of(@item_1.id)).to eq(19)
    end

    it "#cart_items converts all keys to item objects" do
      @cart.add_item(@item_1.id)
      @cart.add_item(@item_2.id)

      expect(@cart.cart_items[0]).to eq(@item_1)
      expect(@cart.cart_items[1]).to eq(@item_2)
    end

    it "#max_item_count? will return true if all an items inventory is already in cart" do
      expect(@cart.max_item_count?(@item_1, 'true')).to eq(nil)

      @cart.add_item(@item_1.id)

      expect(@cart.max_item_count?(@item_1, 'true')).to eq(true)
    end

    it "#min_item_count? will return true if all an item quanitity is being removed when there is only one quantity." do
      cart = Cart.new({
          "#{@item_1.id}" => 2,
         })

      expect(cart.min_item_count?(@item_1, 'false')).to eq(nil)

      cart.subtract_item(@item_1.id)

      expect(cart.min_item_count?(@item_1, 'false')).to eq(true)
    end

    it "#subtotal returns the total price of that item and it's quantity" do
      @cart.add_item(@item_1.id)
      @cart.add_item(@item_1.id)

      expect(@cart.sub_total(@item_1)).to eq(2100)
    end

    it "#grand_total returns the value of all items in cart" do
      @cart.add_item(@item_1.id)
      @cart.add_item(@item_1.id)
      @cart.add_item(@item_2.id)

      expect(@cart.grand_total).to eq(3620)
    end
  end
end

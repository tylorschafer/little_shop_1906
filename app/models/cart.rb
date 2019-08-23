class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def add_item(item_id)
    @contents[item_id.to_s] = count_of(item_id) + 1
  end

  def count_of(item_id)
    @contents[item_id.to_s].to_i
  end

  def cart_items
    @contents.keys.map do |id|
      Item.find(id)
    end
  end

  def sub_total(item)
    item.price * count_of(item.id)
  end

  def grand_total
    cart_items.sum{|item| item.price * count_of(item.id)}
  end

  def remove_item(id)
    @contents.delete(id)
    @contents
  end

  ## Class Methods
end

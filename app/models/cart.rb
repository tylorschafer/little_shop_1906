class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def invalid_item?(item_id)
    Item.where(id: item_id).empty?
  end

  def total_count
    @contents.values.sum
  end

  def add_item(item_id)
    @contents[item_id.to_s] = count_of(item_id) + 1
  end

  def subtract_item(item_id)
    @contents[item_id.to_s] = count_of(item_id) - 1
  end

  def count_of(item_id)
    @contents[item_id.to_s].to_i
  end

  def cart_items
    @contents.keys.map do |id|
      Item.find(id)
    end
  end

  def max_item_count?(item, add)
    return true if count_of(item.id) == item.inventory && add == 'true'
  end

  def min_item_count?(item, add)
    return true if count_of(item.id) <= 1 && add == 'false'
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
end

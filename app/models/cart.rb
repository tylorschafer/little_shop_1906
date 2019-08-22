class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents
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
end

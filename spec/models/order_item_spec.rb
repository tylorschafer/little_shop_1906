require 'rails_helper'

describe OrderItem do
  describe 'Relationships' do
    it {should belong_to :order}
    it {should belong_to :item}
  end
end

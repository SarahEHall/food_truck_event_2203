require './lib/item'
require 'Rspec'

describe Item do
  context 'Iteration 1' do
    before (:each) do
      @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
      @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    end

    it 'exists and has attributes' do
      expect(@item2).to be_an_instance_of(Item)
      expect(@item2.name).to eq("Apple Pie (Slice)")
      expect(@item2.price).to eq(2.50)
    end
  end
end

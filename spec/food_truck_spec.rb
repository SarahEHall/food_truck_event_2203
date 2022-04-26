require './lib/food_truck'
require './lib/item'
require 'Rspec'

describe FoodTruck do
  context 'Iteration 1' do
    before(:each) do
      @food_truck = FoodTruck.new("Rocky Mountain Pies")
      @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    end

    it 'exists and has attributes' do
      expect(@food_truck).to be_an_instance_of(FoodTruck)
      expect(@food_truck.name).to eq("Rocky Mountain Pies")
      expect(@food_truck.inventory).to eq({})
    end

    it 'can check the stock of items' do
      expect(@food_truck.check_stock(@item1)).to eq(0)
    end

    it 'can add items to the inventory' do
      @food_truck.stock(@item1, 25)
      expect(@food_truck.inventory).to eq({@item1 => 25})
    end
  end
end

require './lib/food_truck'
require 'Rspec'

describe FoodTruck do
  context 'Iteration 1' do
    before(:each) do
      @food_truck = FoodTruck.new("Rocky Mountain Pies")
    end
    it 'exists and has attributes' do
      expect(@food_truck).to be_an_instance_of(FoodTruck)
      expect(@food_truck.name).to eq("Rocky Mountain Pies")
      expect(@food_truck.inventory).to eq({})
    end
  end
end

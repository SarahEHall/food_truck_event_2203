require './lib/event'
require './lib/food_truck'
require './lib/item'
require 'Rspec'

describe Event do
  context 'Iteration 2' do
    before(:each) do
      @event = Event.new("South Pearl Street Farmers Market")
      @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
      @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
      @food_truck3 = FoodTruck.new("Palisade Peach Shack")
      @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
      @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
      @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
      @food_truck1.stock(@item1, 35)
      @food_truck1.stock(@item2, 7)
      @food_truck2.stock(@item4, 50)
      @food_truck2.stock(@item3, 25)
      @food_truck3.stock(@item1, 65)
    end

    it 'exists and has attributes' do
      expect(@event).to be_an_instance_of(Event)
      expect(@event.name).to eq("South Pearl Street Farmers Market")
      expect(@event.food_trucks).to eq([])
    end

    it 'can add food trucks' do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
      expect(@event.food_trucks).to eq([@food_truck1, @food_truck2, @food_truck3])
    end

    it 'can return a list of all food truck names' do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
      expect(@event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end

    it 'can return a list of truks that sell a certain item' do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
      expect(@event.food_trucks_that_sell(@item1)).to eq([@food_truck1, @food_truck3])
      expect(@event.food_trucks_that_sell(@item4)).to eq([@food_truck2])
    end
  end

  context 'Iteration 3' do
    before(:each) do
      @event = Event.new("South Pearl Street Farmers Market")
      @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
      @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
      @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
      @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
      @food_truck1.stock(@item1, 35)
      @food_truck1.stock(@item2, 7)
      @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
      @food_truck2.stock(@item4, 50)
      @food_truck2.stock(@item3, 25)
      @food_truck3 = FoodTruck.new("Palisade Peach Shack")
      @food_truck3.stock(@item1, 65)
      @food_truck3.stock(@item3, 10)
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
    end

    it 'can return an alphabetized list of items sold at the event' do
      expect(@event.sorted_items_list).to eq([@item2, @item4, @item1, @item3])
    end

    it 'can return a hash containing total quantity for an item, and which trucks sell it' do
    expected = { @item1 => {quantity: 100, food_trucks: [@food_truck1, @food_truck3]},
      @item2 => {quantity: 7, food_trucks: [@food_truck1]},
      @item4 => {quantity: 50, food_trucks: [@food_truck2]},
      @item3 => {quantity: 35, food_trucks: [@food_truck2, @food_truck3]}}
    expect(@event.total_inventory).to eq(expected)
    end

    it 'can return a list of overstocked items' do
      expect(@event.overstocked_items).to eq([@item1])
    end
  end

  context 'Iteration 4' do
    before(:each) do
      @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
      @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
      @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
      @item5 = Item.new({name: 'Onion Pie', price: '$25.00'})
      @event = Event.new("South Pearl Street Farmers Market")
      @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
      @food_truck1.stock(@item1, 35)
      @food_truck1.stock(@item2, 7)
      @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
      @food_truck2.stock(@item4, 50)
      @food_truck2.stock(@item3, 25)
      @food_truck3 = FoodTruck.new("Palisade Peach Shack")
      @food_truck3.stock(@item1, 65)
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
    end

    it 'can return a formatted date based on when it was created' do
      allow(Date).to receive(:today).and_return(Date.parse('24-02-2020'))

      event = Event.new("South Pearl Street Farmers Market")
      expect(event.date).to eq("24/02/2020")
    end

    it 'cannot sell items that are not in stock, or that do not have enough stock' do
      expect(@event.sell(@item1, 200)).to eq(false)
      expect(@event.sell(@item5, 1)).to eq(false)
    end

    it 'can sell items that are in stock, and subtract the sold amount from the truck it sold out of' do
      expect(@event.sell(@item4, 5)).to eq(true)
      expect(@food_truck2.check_stock(@item4)).to eq(45)
    end

    it 'can sell more than one truck has if another truck has enough' do
      expect(@event.sell(@item1, 40)).to eq(true)
      expect(@food_truck1.check_stock(@item1)).to eq(0)
      expect(@food_truck3.check_stock(@item1)).to eq(60)
    end
  end
end

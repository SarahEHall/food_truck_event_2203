require './lib/food_truck'
require 'date'
class Event

  attr_reader :name, :food_trucks, :date

  def initialize(name)
    @name = name
    @food_trucks = []
    @date = Date.today.strftime("%d/%m/%Y")
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map { |truck| truck.name }
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all { |truck| truck.inventory.include?(item)}
  end

  def sorted_items_list
    all_items = @food_trucks.map { |truck| truck.inventory.keys}
    all_items = all_items.flatten.uniq
    all_items.sort_by { |item| item.name}
  end

  def total_inventory
    total_inv = {}
    @food_trucks.each do |truck|
      truck.inventory.each do |item, amount|
        if total_inv.keys.include?(item)
          total_inv[item][:quantity] += amount
        else
          total_inv[item] = {quantity: amount, food_trucks: food_trucks_that_sell(item)}
        end
      end
    end
    return total_inv
  end

  def overstocked_items
    total_inv = total_inventory
    total_inv.keys.find_all { |item| total_inv[item][:quantity] > 50 && total_inv[item][:food_trucks].length > 1 }
  end

  def sell(item, amount)
    total_inv = total_inventory
    if total_inv[item][:quantity] < amount || total_inv[item].nil?
      return false
    else
      total_inv[item][:quantity] -= amount
      total_inv[item][:food_trucks].each do |truck|
        if amount > truck.inventory[item]
          amount = amount - truck.inventory[item]
          truck.inventory[item] = 0
        else
          truck.inventory[item] -= amount
          return true
        end
      end
    end
  end

end

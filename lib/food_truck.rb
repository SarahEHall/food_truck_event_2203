class FoodTruck

  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    if !@inventory.include?(item)
      return 0
    else
      @inventory[item]
    end
  end

  def stock(item, amount)
    if @inventory.keys.include?(item)
      @inventory[item] += amount
    else
      @inventory[item] = amount
    end
  end
end

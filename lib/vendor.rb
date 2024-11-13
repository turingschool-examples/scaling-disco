class Vendor
  attr_reader :name, :inventory
     
  def initialize(name)
      @name = name
      @inventory = {}
  end

  def stock(item, quantity)
    @inventory[item] = quantity
  end

  def check_stock(item)
    if item == @inventory[:item]
      return @inventory[:quantity]
    end
  end

  def potential_revenue
    total = 0
    @inventory.each do |item|
      item.price * item.quantity
    end
    total
  end
end

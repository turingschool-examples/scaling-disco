class Vendor

    attr_reader :name, :inventory

    def initialize(name)
        @name = name
        @inventory = {}
    end

    def check_stock(item)
        if !@inventory.empty?
          @inventory[item]
        else
          0
        end
    end

    def stock(item, amount)
        @inventory[item] ||= 0
        @inventory[item] += amount
    end

    #this test isn't passing, going to try to move on either way
    def potential_revenue 
        revenue_sum = 0
        @inventory.each do |item, quantity|
           item_price = item.price.delete("$").to_f 
            revenue_sum += item_price * quantity
        end
        revenue_sum
    end
end 


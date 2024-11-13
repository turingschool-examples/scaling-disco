class Market

    attr_reader :name, :vendors

    def initialize(name)
        @name = name
        @vendors = []
    end

    def add_vendor(vendor)
        @vendors << vendor 
    end

    def vendor_names
        names = []
        @vendors.each do |vendor|
          names << vendor.name
        end
          names
    end
    
    def vendors_that_sell(item)
        list = []
        @vendors.each do |vendor|
            if vendor.inventory.include?(item)
                list << vendor  
            end
        end
        list
    end

    def sorted_item_list
        sorted_items = []
        @vendors.each do |vendor|
            vendor.inventory.each do |item, quantity|
                sorted_items << item.name
            end
        end
        sorted_items.uniq.sort
    end

        #can't figure this one out
    def overstocked_items
        overstocked = []
        @vendors.each do |vendor|
            vendor.inventory.each do |item, quantity|
                if 
            end
        end
    end
end

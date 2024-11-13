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
    vendor_names = []
    @vendors.each do |vendor|
      vendor_names << vendor.name
    end
    vendor_names
  end

  def vendors_that_sell(item)
    
  end

  def sorted_item_list
    item_names = []
    @vendors.each do |vendor|
      vendor.each do |inventory|
        inventory.each do |item|
          item_names << item.name
        end
      end
    end
    item_names.uniq
  end

end

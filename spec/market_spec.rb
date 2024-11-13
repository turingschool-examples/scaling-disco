require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do 
  before(:each) do
    @item1 = Item.new({name: "Peach", price: "$0.75"})
    @item2 = Item.new({name: "Tomato", price: "$0.50"})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @market = Market.new("South Pearl Street Farmers Market")
  end

  it 'exists' do #1
      expect(@market).to be_a(Market)
  end

  it 'has a name' do #2
    expect(@market.name).to eq("South Pearl Street Farmers Market")
  end

  it 'defults empty array for vendors' do #3
    expect(@market.vendors).to eq([])
  end

  describe '#add_vendor' do 
    it 'adds vendors to array' do #4
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    end
  end

  describe '#vendor_names' do
    it 'returns list of vendor names' do #5
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end
  end

  describe '#vendors_that_sell' do
    it 'returns list of vendor names' do #6
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)


      expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
      expect(@market.vendors_that_sell(@item4)).to eq([@vendor2])
    end
  end

  describe '#sorted_item_list' do
    it 'returns list in stock item names sorted alphabetically' do #7
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Totmato"])
    end
  end

  describe '#total_inventory' do #8
    it 'Reports the quantities of all items sold at the market. Specifically, it should return a hash with items as keys and hashes as values - this sub-hash should have two key/value pairs: quantity pointing to total inventory for that item and vendors pointing to an array of the vendors that sell that item.' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.total_inventory).to eq({})
    end
  end

  describe '#overstocked_items' do #9
    it 'An array of `Item` objects that are overstocked. An item is overstocked if it is sold by more than 1 vendor AND the total quantity is greater than 50.' do
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.overstocked_items).to eq([@item1])
    end
  end

end
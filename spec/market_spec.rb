require './lib/item'
require './lib/vendor'
require './lib/market'
require 'pry'

RSpec.describe Market do
    before(:each) do
        @market = Market.new("South Pearl Street Farmers Market")   

        @vendor1 = Vendor.new("Rocky Mountain Fresh")
        @vendor2 = Vendor.new("Ba-Nom-a-Nom")   
        @vendor3 = Vendor.new("Palisade Peach Shack")    

        @item1 = Item.new({name: 'Peach', price: "$0.75"})
        @item2 = Item.new({name: 'Tomato', price: '$0.50'})
        @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
        @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    end

    it 'exists' do
        expect(@market).to be_a(Market)
    end

    it 'can add vendors to the market' do 
        @market.add_vendor(@vendor1) 
        @market.add_vendor(@vendor2) 
        @market.add_vendor(@vendor3) 

        expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    end

    it 'can list the vendors by name' do 
        @market.add_vendor(@vendor1) 
        @market.add_vendor(@vendor2) 
        @market.add_vendor(@vendor3) 

        expect(@market.vendor_names).to eq(["Rocky Mountain Fresh","Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end

    it 'can list vendors that sell a specific item' do
        @market.add_vendor(@vendor1) 
        @market.add_vendor(@vendor2) 
        @market.add_vendor(@vendor3) 

        @vendor1.stock(@item1, 35) 
        @vendor1.stock(@item2, 7) 
        @vendor2.stock(@item4, 50) 
        @vendor2.stock(@item3, 25)
        @vendor3.stock(@item1, 65)  

        expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
        expect(@market.vendors_that_sell(@item4)).to eq([@vendor2])
    end

    it 'can sort all items in stock alphabetically' do
        @market.add_vendor(@vendor1) 
        @market.add_vendor(@vendor2) 
        @market.add_vendor(@vendor3) 

        @vendor1.stock(@item1, 35) 
        @vendor1.stock(@item2, 7) 
        @vendor2.stock(@item4, 50) 
        @vendor2.stock(@item3, 25)
        @vendor3.stock(@item1, 65)  

        expect(@market.sorted_item_list).to eq(["Banana Nice Cream","Peach", "Peach-Raspberry Nice Cream", "Tomato"])
    end

    it 'can determine if an item is overstocked at the market' do
        @market.add_vendor(@vendor1) 
        @market.add_vendor(@vendor2) 
        @market.add_vendor(@vendor3) 

        @vendor1.stock(@item1, 35) 
        @vendor1.stock(@item2, 70) 
        @vendor2.stock(@item4, 50) 
        @vendor2.stock(@item3, 25)
        @vendor3.stock(@item1, 65) 

        expect(@market.overstocked_items).to eq([@item1, @item2])
    end
end

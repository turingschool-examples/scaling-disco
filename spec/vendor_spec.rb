require './lib/item'
require './lib/vendor'

RSpec.describe Vendor do
  before(:each) do 
      @item1 = Item.new({name: 'Peach', price: "$0.75"})
      @item2 = Item.new({name: 'Tomato', price: '$0.50'})
      @vendor1 = Vendor.new("Rocky Mountain Fresh")
      @vendor2 = Vendor.new("Ba-Nom-a-Nom")
      @vendor3 = Vendor.new("Palisade Peach Shack")  
  end

  it 'exists' do #1
      expect(@vendor1).to be_a(Vendor)
  end

  it 'has a name' do #2
    expect(@vendor1.name).to eq("Rocky Mountain Fresh")
  end

  it 'has defaults an empty hash' do #3
    expect(@vendor1.inventory).to eq({})
  end

  describe '#stock' do
    it 'adds item and quantity to inventory hash' do #4
      @vendor1.stock(@item1, 30)

      expect(@vendor1.inventory).to eq({@item1 => 30})
    end

    it 'can add multiple items and keep a running tally of quantity' do #5
      @vendor1.stock(@item1, 30)
      @vendor1.stock(@item1, 25)
      @vendor1.stock(@item2, 12) 
      expect(@vendor1.inventory).to eq({@item1 => 55, @item2 => 12})
    end
  end

  describe '#check_stock' do
    it 'defaults to zero stock' do #6
      expect(@vendor1.check_stock(@item1)).to eq(0)
    end

    it 'provides quantity of item' do #7
      @vendor1.stock(@item1, 30)
      
      expect(@vendor1.check_stock(@item1)).to eq(30)
    end

    it 'provides accurate running tally of stock' do #8
      @vendor1.stock(@item1, 30)
      @vendor1.stock(@item1, 25) 

      expect(@vendor1.check_stock(@item1)).to eq(55)
    end
  end

  describe '#potential_revenue' do
    it 'accurately determines potential revenue' do #9
      @vendor1.stock(@item1, 35)     
      @vendor1.stock(@item2, 7)     
      @vendor2.stock(@item4, 50)     
      @vendor2.stock(@item3, 25) 
      @vendor3.stock(@item1, 65)

      expect(@vendor1.potential_revenue).to eq(29.75)
      expect(@vendor2.potential_revenue).to eq(345.00)
      expect(@vendor3.potential_revenue).to eq(48.75)
    end
  end
end





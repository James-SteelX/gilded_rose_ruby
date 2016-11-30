require './lib/gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("Stuff", 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq "Stuff"
    end

    context 'Sell In' do
      it 'can go negative' do
        items = [Item.new("Sword", 0, 20)]
        described_class.new(items).update_quality
        expect(items[0].sell_in).to eq -1
      end

      it 'adjusts the sellin value' do
        items = [Item.new("Sword", 1, 1)]
        described_class.new(items).update_quality
        expect(items[0].sell_in).to eq 0
      end
    end

    context 'Quality' do
      it 'never goes negative' do
        items = [Item.new("Artifact", 4, 0)]
        described_class.new(items).update_quality
        expect(items[0].quality).to eq 0
      end

      it 'adjusts the quality value' do
        items = [Item.new("Artifact", 4, 3)]
        described_class.new(items).update_quality
        expect(items[0].quality).to eq 2
      end

      it 'adjusts quality twice as fast after sell_in is passed' do
        items = [Item.new("Artifact", -1, 10)]
        described_class.new(items).update_quality
        expect(items[0].quality).to eq 8
      end
    end

    context 'Aged Brie' do
      it 'increases the quality of Aged Brie' do
        items = [Item.new("Aged Brie", 4, 10)]
        described_class.new(items).update_quality
        expect(items[0].quality).to eq 11
      end

      it 'increases the quality of Aged Brie by 2 after sell_In reached' do
        items = [Item.new("Aged Brie", 0, 10)]
        described_class.new(items).update_quality
        expect(items[0].quality).to eq 12
      end

      it 'wont increase quality above 50' do
        items = [Item.new("Aged Brie", 4, 50)]
        described_class.new(items).update_quality
        expect(items[0].quality).to eq 50
      end
    end

    context 'Sulfuras' do
    #needs fixing.
      it 'wont change the quality of Sulfuras' do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 12, 20)]
        described_class.new(items).update_quality
        expect(items[0].quality).to eq 20
      end

      it 'wont change the sell_in of Sulfuras' do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 12, 20)]
        described_class.new(items).update_quality
        expect(items[0].sell_in).to eq 12
      end
    end

    context 'Backstage Pass' do
     it 'changes backstage quality by 1 when sellin is > 10' do
       items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 20)]
       described_class.new(items).update_quality
       expect(items[0].quality).to eq 21
     end

     it 'changes backstage quality by 2 when sellin is < 10' do
       items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 20)]
       described_class.new(items).update_quality
       expect(items[0].quality).to eq 22
     end

     it 'changes backstage quality by 3 when sellin is < 5' do
       items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 20)]
       described_class.new(items).update_quality
       expect(items[0].quality).to eq 23
     end

     it 'changes backstage quality to 0 when sellin 0' do
       items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 30)]
       described_class.new(items).update_quality
       expect(items[0].quality).to eq 0
     end
    end

    context 'Conjured' do
      it 'degrades twice as fast as normal items' do
        items = [Item.new("Conjured cookie crumbs", 2, 4)]
        described_class.new(items).update_quality
        expect(items[0].quality).to eq 2
      end

      it 'the quality wont go negative' do
        items = [Item.new("Conjured cookie crumbs", 2, 1)]
        described_class.new(items).update_quality
        expect(items[0].quality).to eq 0
      end
    end
  end
end

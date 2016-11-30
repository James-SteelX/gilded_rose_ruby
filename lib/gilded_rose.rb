require_relative 'items'

class GildedRose

  AGED_BRIE = 'Aged Brie'
  SULFURAS = 'Sulfuras, Hand of Ragnaros'
  BACKSTAGE_TICKETS = "Backstage passes to a TAFKAL80ETC concert"
  CONJURED = 'Conjured cookie crumbs'

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      item_check(item)
    end
  end

  def item_check(product)
    if product.name == AGED_BRIE
      aged_brie(product)
    elsif product.name == SULFURAS
      sulfuras(product)
    elsif product.name == BACKSTAGE_TICKETS
      backstage_tickets(product)
    elsif product.name == CONJURED
      conjured(product)
    else
      normal_product(product)
    end
  end

  private

  def conjured(product)
    product.sell_in -= 1
    if product.quality - 2 < 0
      product.quality -= 1
      return
    end
    product.quality -= 2
  end

  def sulfuras(sulfuras)
    sulfuras.quality += 0
    sulfuras.sell_in -= 0
  end

  def normal_product(product)
   product.sell_in -= 1
   return if product.quality == 0
   product.quality -= 1
   product.quality -= 1 if product.sell_in <= 0
  end

  def aged_brie(brie)
   brie.sell_in -= 1
   return if brie.quality == 50
   brie.quality += 1
   brie.quality += 1 if brie.sell_in <= 0
  end

  def backstage_tickets(ticket)
    if ticket.sell_in == 0 then ticket.quality = 0 end
    return if ticket.sell_in == 0
    ticket.sell_in -= 1
    if ticket.sell_in > 10
      ticket.quality += 1
    elsif ticket.sell_in < 5
      ticket.quality += 3
    else
      ticket.quality += 2
    end
  end
end

require "./entity/card/card"
require "./entity/card/unflippedcard"
require "./entity/card/nilcard"
require "./entity/card/emptycard"
require "./entity/table/abstracttable"

class NilTable < AbstractTable
  def initialize(table)
    deck = [UnflippedCard.new(table), NilCard.new] + Array.new(8) { |i| EmptyCard.new }
    super(deck)
    @next = 1
    fill_stacks
  end

  def fill_next(suit)
    @stacks[10 - @next] = [Card.new(suit, 1)]
    @next += 1
  end

  protected

  def draw_top_card
    card = @deck.first
    @deck.delete_at(0)
    return card
  end

  def fill_stacks
    @stacks.each do |stack|
      stack << draw_top_card
    end
  end
end

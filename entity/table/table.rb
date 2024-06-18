require "./entity/card/card"
require "./entity/table/abstracttable"

class Table < AbstractTable
  def initialize(deck)
    super(deck)
    fill_stacks
    deal
  end

  protected

  def draw_top_card
    index_card = rand(@deck.length)
    card = @deck.at(index_card)
    @deck.delete_at(index_card)
    return card
  end

  def fill_stacks
    @stacks.each.with_index do |stack, index|
      break if @deck.length == 0
      current_count_card = (index > 3) ? 4 : 5
      (1..current_count_card).each do |i|
        stack << draw_top_card
      end
    end
  end
end

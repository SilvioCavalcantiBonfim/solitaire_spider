require "./entity/card/card"

class AbstractTable
  def initialize(deck, stack = 10)
    @deck = deck
    @stacks = Array.new(stack) { Array.new }
    @partial_stack = Array.new
  end

  def deal
    @stacks.each do |stack|
      break if @deck.length == 0
      card = draw_top_card
      card.flip; stack << card unless card.nil?
    end
  end

  def move(amount, from, to)
    unless validate(amount, from, to)
      raise Error, "invalid move"
    end
    process_move(amount, from, to)
    @stacks.each do |stack|
      stack.last.flip
    end
  end

  def deck_empty?
    @deck.length == 0
  end

  def render
    deeping = -Float::INFINITY
    partial_layer = Array.new

    @stacks.each.with_index do |stack, index|
      partial_render = stack.map.with_index { |card, i| card.render(stack.length - i) unless card.nil? }.flatten
      deeping = [deeping, partial_render.length].max
      partial_layer.push(partial_render)
    end

    layer = partial_layer.map { |col| col + Array.new(deeping - col.length, "       ") }.transpose
    puts layer.map { |col| col.join (" ") }.join("\n")
  end

  protected

  def draw_top_card
    raise NotImplementedError
  end

  def fill_stacks
    raise NotImplementedError
  end

  private

  def validate(amount, from, to)
    validate = true
    validate &= from.between?(1, 10)
    validate &= to.between?(1, 10)
    from_card = @stacks[from - 1].at(-amount)
    to_card = @stacks[to - 1].last
    validate &= from_card.is_flipped?
    validate &= !from.equal?(to)

    chain_is_valid = true

    for i in ((-amount)..-2)
      puts "#{@stacks[from - 1].at(i).number} and #{@stacks[from - 1].at(i + 1).number}"
      chain_is_valid &= @stacks[from - 1].at(i).number == (@stacks[from - 1].at(i + 1).number + 1)
    end
    validate &= chain_is_valid
    validate &= from_card.number == to_card.number - 1
    validate
  end

  def process_move(amount, from, to)
    (1..amount).each do
      stack = @stacks[from - 1]
      @partial_stack.push(stack.last)
      stack.pop
    end

    (1..amount).each do
      stack = @stacks[to - 1]
      stack.push(@partial_stack.last)
      @partial_stack.pop
    end
    # sleep(12)
  end
end

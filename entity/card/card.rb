require "./util/color"

class Card

  # suit = 0 = ♠, 1 = ♥, 2 = ♣, 3 = ♦
  # number = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 = J, 12 = Q, 13 = K
  # fliped = true ou false

  @@SUIT_MAP = ["♠", "♥", "♣", "♦"]
  @@COLOR_MAP = [Color::WHITE, Color::RED]
  @@NUMBER_MAP = { 1 => "A", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9", 10 => "10", 11 => "J", 12 => "Q", 13 => "K" }

  attr_reader :suit, :number

  def initialize(suit, number)
    @suit = suit
    @number = number
    @flip = false
    @char_suit = @@SUIT_MAP[suit]
    @char_number = @@NUMBER_MAP[number]
    @color = @@COLOR_MAP[suit % 2]
  end

  def flip
    @flip = true
  end

  def is_flipped?
    return @flip
  end

  def render(index = 1)
    index != 1 ? partial_front_card(index) : front_card
  end

  private

  def partial_front_card(index)
    is_flipped? ? [
      top("#{index}"),
      "│︎#{Color.colorize(@char_number.ljust(4), @color)}#{Color.colorize(@char_suit, @color)}│︎",
    ] : [top(index)]
  end

  def front_card
    [
      top("1"),
      "│︎#{Color.colorize(@char_number.ljust(4), @color)}#{Color.colorize(@char_suit, @color)}│︎",
      "│︎     │︎",
      "│︎#{Color.colorize(@char_suit, @color)}#{Color.colorize(@char_number.rjust(4), @color)}│︎", "╰︎─︎─︎─︎─︎─︎╯︎",
    ]
  end

  def top(index = "")
    "╭#{index.to_s.ljust(5, "─")}╮"
  end
end

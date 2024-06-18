require "./util/color"

class UnflippedCard < Card
  def initialize(table)
    @table = table
  end

  def render(index = 1)
    @table.deck_empty? ? ["╭︎─︎─︎─︎─︎─︎╮︎", "│︎     │︎", "│︎     │︎", "│︎     │︎", "╰︎─︎─︎─︎─︎─︎╯︎"] : ["╭︎─︎─︎─︎─︎─︎╮︎", "│︎░︎░︎░︎░︎░︎│︎", "│︎░︎░︎░︎░︎░︎│︎", "│︎░︎░︎░︎░︎░︎│︎", "╰︎─︎─︎─︎─︎─︎╯︎"]
  end
end

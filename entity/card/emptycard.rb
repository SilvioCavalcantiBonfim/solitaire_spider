require "./util/color"

class EmptyCard < Card
  def initialize
  end

  def render(index = 1)
    ["╭︎     ╮︎", "       ", "       ", "       ", "╰︎     ╯︎"]
  end
end

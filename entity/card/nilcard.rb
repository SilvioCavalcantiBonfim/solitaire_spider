require "./util/color"

class NilCard < Card
  def initialize
  end

  def render(index = 1)
    Array.new (5) { |i| "       " }
  end
end

require "./entity/card/card"
require "./entity/table/niltable"
require "./entity/table/table"

class Bootstrap
  def initialize
    @deck = Array.new

    for i in 1..13
      (0..3).each do |j|
        @deck.push(Card.new(j, i), Card.new(j, i))
      end
    end

    @table = Table.new(@deck)
    @nilTable = NilTable.new(@table)
  end

  def run
    loop do
      system "clear"
      render
      case gets.chomp.upcase
      when "C"
        @table.deal
      when "M"
        begin
          amount = 0
          from = 0
          to = 0
          print "Digite o número de cartas que deseja mover: "
          amount = gets.chomp.to_i
          print "Digite o número da coluna de onde você está movendo as cartas: "
          from = gets.chomp.to_i
          print "Digite o número da coluna para onde você deseja mover as cartas: "
          to = gets.chomp.to_i
          @table.move(amount, from, to)
        rescue => e
          puts "Movimento #{Color.colorize("inválido", Color::RED)}."
          puts e
          sleep(10)
        end
      else
        puts "Ação #{Color.colorize("inválido", Color::RED)}."
        sleep(1)
      end
    end
  end

  private

  def render
    @nilTable.render

    puts (1..10).map { |i| "#{i}".center(7, "-") }.join("+")

    @table.render
    puts "[#{Color.colorize("C", Color::YELLOW)}] #{Color.colorize("C", Color::YELLOW)}omprar cartas."
    puts "[#{Color.colorize("M", Color::GREEN)}] #{Color.colorize("M", Color::GREEN)}over para."
    print "\nEscolha uma #{Color.colorize("ação", Color::BLUE)}: "
  end
end

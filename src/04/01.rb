class Completable
  attr_reader :number_map, :numbers

  def initialize(numbers)
    @numbers = numbers
    @number_map = {}
    @numbers.each_with_index do |number, idx|
      @number_map[number] ||= []
      @number_map[number] << idx
    end
  end

  def length
    numbers.length
  end

  def mark(number)
    return false if number_map[number].nil?

    number_map[number].each do |i|
      numbers[i] = nil
    end

    numbers.compact.empty?
  end

  def sum
    numbers.compact.reduce(:+) || 0
  end
end

class Board
  attr_reader :columns, :rows, :raw

  def initialize(numbers)
    @raw = numbers
    @rows = numbers.split("\n").map{|row| row.strip.split(/\s+/).map(&:to_i)}.map { |numbers| Completable.new(numbers) }
    @columns = 0.upto(rows[0].length - 1).map {|i| rows.map{|r| r.numbers[i]} }.map { |numbers| Completable.new(numbers) }
  end

  def completables
    rows + columns
  end

  def mark(number)
    completables.map { |completable| completable.mark(number) }.any?
  end

  def sum
    rows.reduce(0) { |accum, row| accum + row.sum }
  end
end

def find_winner(order, boards)
  order.each do |number|
    boards.each do |board|
      return [board, number] if board.mark(number)
    end
  end
end

def find_loser(order, boards)
  completed = {}
  order.each do |number|
    boards.each_with_index do |board, idx|
      if !completed[idx] and board.mark(number)
        completed[idx] = true
        return [board, number] if completed.length == boards.length
      end
    end
  end
end

def play(order, boards)
  results = {}
  completed = {}
  order.each do |number|
    boards.each_with_index do |board, idx|
      if !completed[idx] and board.mark(number)
        if results[:winning_board].nil?
          results[:winning_board] = board
          results[:winning_number] = number
        end
        completed[idx] = true
        if completed.length == boards.length
          results[:losing_board] = board
          results[:losing_number] = number
          return results
        end
      end
    end
  end
end

input_file = 'inputs/04/01.txt'
inputs = File.read(input_file).split("\n\n")
order = inputs.shift.split(',').map(&:to_i)
boards = inputs.map { |board| Board.new(board) }

results = play(order, boards)
puts "Part 1: #{results[:winning_board].sum * results[:winning_number]}"
puts "Part 2: #{results[:losing_board].sum * results[:losing_number]}"

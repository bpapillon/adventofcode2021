# INPUT_FILE = 'inputs/05/01.txt'
INPUT_FILE = 'inputs/05/example.txt'
inputs = File.read(INPUT_FILE).split("\n")

diagram = Hash.new(0)
inputs.each do |input|
  match = input.match(/^([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)$/)
  next unless match

  x1, y1, x2, y2 = match[1..4].map(&:to_i)
  y = [y1, y2].sort
  x = [x1, x2].sort

  if x1 == x2
    for i in (y.min..y.max)
      diagram[[x1, i]] += 1
    end
  elsif y1 == y2
    for i in (x.min..x.max)
      diagram[[i, y1]] += 1
    end
  end
end

puts diagram.select { |point, count| count > 1 }.length

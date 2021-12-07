INPUT_FILE = 'inputs/05/01.txt'
# INPUT_FILE = 'inputs/05/example.txt'
inputs = File.read(INPUT_FILE).split("\n")

diagram = Hash.new(0)
inputs.each do |input|
  match = input.match(/^([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)$/)
  next unless match

  x1, y1, x2, y2 = match[1..4].map(&:to_i)
  xPoints = if x1 > x2
              x1.downto(x2)
            elsif x1 < x2
              x1.upto(x2)
            end
  yPoints = if y1 > y2
              y1.downto(y2)
            elsif y1 < y2
              y1.upto(y2)
            end
  xPoints ||= [x1] * yPoints.to_a.length
  yPoints ||= [y1] * xPoints.to_a.length
  xPoints.zip(yPoints).each do |x, y|
    diagram[[x,y]] += 1
  end
end

puts diagram.select { |point, count| count > 1 }.length

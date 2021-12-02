inputs = File.read('inputs/02/01.txt').split("\n")

fMap = {
  down: ->(p, d, a, x) { [p, d, a + x] },
  up: ->(p, d, a, x) { [p, d, a - x] },
  forward: ->(p, d, a, x) { [p + x, d + a * x, a] },
}
position, depth, aim = [0, 0, 0]
inputs.each do |input|
  cmd, val = input.split(' ')
  position, depth, aim = fMap[cmd.to_sym].call(position, depth, aim, val.to_i)
end

puts position * depth

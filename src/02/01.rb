inputs = File.read('inputs/02/01.txt').split("\n")

dirMap = {
  forward: [1, 0],
  backward: [-1, 0],
  up: [0, -1],
  down: [0, 1],
}
position = 0
depth = 0
inputs.each do |input|
  cmd, val = input.split(' ')
  dirPos, dirDepth = dirMap[cmd.to_sym]
  position += dirPos * val.to_i
  depth += dirDepth * val.to_i
end

puts position * depth

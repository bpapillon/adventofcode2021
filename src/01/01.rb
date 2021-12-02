depths = File.read('inputs/01/01.txt').split("\n").map(&:to_i)
descents = 0

depths.each_with_index do |depth, idx|
  descents += 1 if idx > 0 && depth > depths[idx - 1]
end

puts descents

depths = File.read('inputs/01/01.txt').split("\n").map(&:to_i)
descents = 0
prevWindowSum = nil

depths.each_with_index do |depth, idx|
  break if idx + 2 >= depths.length

  windowSum = depths[idx..idx + 2].reduce(:+)
  descents += 1 if prevWindowSum != nil && windowSum > prevWindowSum
  prevWindowSum = windowSum
end

puts descents

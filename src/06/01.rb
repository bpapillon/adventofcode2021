require 'json'

# INPUT_FILE = 'inputs/06/example.txt'
INPUT_FILE = 'inputs/06/01.txt'

fish = File.read(INPUT_FILE).split(',').map(&:to_i)

def count_the_fishies(initial, days)
  counts = 0.upto(8).map { |i| initial.count(i) }
  days.times do |i|
    counts[7] += counts[0]
    counts << counts.shift
  end
  counts.reduce(:+)
end

puts count_the_fishies(fish, 80)
puts count_the_fishies(fish, 256)

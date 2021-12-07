require 'json'

INPUT_FILE = 'inputs/07/01.txt'
# INPUT_FILE = 'inputs/07/example.txt'

def calculate_gas(freq_map, val)
  freq_map.reduce(0) { |accum, (k, v)| accum += k === val ? 0 : gas(k, val) * v }
end

def gas(x, y)
  1.upto((x - y).abs).reduce(0) { |accum, i| accum + i }
end

positions = File.read(INPUT_FILE).split(',').map(&:to_i)
freq_map = positions.reduce(Hash.new(0)) { |accum, val| accum[val] += 1; accum }
gas_map = freq_map.keys.reduce(Hash.new(0)) { |accum, key| accum[key] = calculate_gas(freq_map, key.to_i); accum }
_, least_gas = gas_map.to_a.sort_by(&:last).first
puts least_gas

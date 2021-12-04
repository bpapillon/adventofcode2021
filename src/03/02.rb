inputs = File.read('inputs/03/01.txt').split("\n")

def binary_to_decimal(binary_string)
  binary_string.reverse.chars.map.with_index do |digit, index|
    digit.to_i * 2**index
  end.sum
end

def get_rating(numbers, comparison=:max_by, default_bit="1", idx=0)
  position_bits = numbers.map { |x| x[idx] }
  freq = position_bits.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
  bit = freq.values.uniq.length == 2 ? position_bits.send(comparison){ |v| freq[v] } : default_bit
  matches = numbers.select{ |number| number[idx] == bit }
  return get_rating(matches, comparison, default_bit, idx + 1) if matches.any?

  binary_to_decimal(numbers[-1])
end

puts get_rating(inputs) * get_rating(inputs, :min_by, "0")

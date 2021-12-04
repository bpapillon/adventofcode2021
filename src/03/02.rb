inputs = File.read('inputs/03/01.txt').split("\n")

def binaryToDecimal(binaryString)
  binaryString.reverse.chars.map.with_index do |digit, index|
    digit.to_i * 2**index
  end.sum
end

def getRating(numbers, comparison=:max_by, defaultBit="1", idx=0)
  positionBits = numbers.map { |x| x[idx] }
  freq = positionBits.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
  bit = freq.values.uniq.length == 2 ? positionBits.send(comparison){ |v| freq[v] } : defaultBit
  matches = numbers.select{ |number| number[idx] == bit }
  return getRating(matches, comparison, defaultBit, idx + 1) if matches.length > 0

  binaryToDecimal(numbers[-1])
end

puts getRating(inputs) * getRating(inputs, :min_by, "0")

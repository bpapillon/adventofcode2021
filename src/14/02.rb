INPUT_FILE = 'inputs/14/01.txt'
# INPUT_FILE = 'inputs/14/example.txt'

def initial_state(filename)
  lines = File.read(filename).split("\n")
  template = lines[0].chars
  rules = lines[2..-1].map do |line|
    parts = line.split(" -> ")
    [parts[0].chars, parts[1]]
  end.to_h

  pairs = Hash.new(0)
  template.each_with_index do |char, idx|
    break if idx >= template.length - 1

    pairs[[char, template[idx + 1]]] += 1
  end
  first_pair = [template[0], template[1]]

  [pairs, first_pair, rules]
end

def score(pairs, first_pair)
  char_freq = Hash.new(0)
  pairs.each do |pair, count|
    x, y = pair
    char_freq[x] += count if pair == first_pair
    char_freq[y] += count
  end
  sorted_freq = char_freq.to_a.sort_by(&:last)
  sorted_freq.last.last - sorted_freq.first.last
end

def step(pairs, first_pair, rules)
  new_pairs = pairs.clone
  new_first_pair = first_pair.clone
  pairs.each do |pair, count|
    if rules[pair]
      new_pairs[pair] -= count
      new_pairs[[pair[0], rules[pair]]] += count
      new_pairs[[rules[pair], pair[1]]] += count

      if pair == first_pair
        new_first_pair = [pair[0], rules[pair]]
      end
    end
  end
  [new_pairs, new_first_pair]
end

pairs, first_pair, rules = initial_state(INPUT_FILE)
40.times do
  pairs, first_pair = step(pairs, first_pair, rules)
end
puts score(pairs, first_pair)

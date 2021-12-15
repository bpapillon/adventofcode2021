require 'json'
require 'time'

INPUT_FILE = 'inputs/14/01.txt'
# INPUT_FILE = 'inputs/14/example.txt'

def insertion(pair, rules)
  return rules[pair] ? [rules[pair], pair[1]] : [pair[1]]
end

def step(template, rules)
  new_template = []
  template.each_with_index do |char, idx|
    break if idx >= template.length - 1

    pair = [char, template[idx + 1]]
    new_template += insertion(pair, rules)
  end
  [template[0]] + new_template
end

lines = File.read(INPUT_FILE).split("\n")
template = lines[0].chars
rules = lines[2..-1].map do |line|
  parts = line.split(" -> ")
  [parts[0].chars, parts[1]]
end.to_h

10.times do
  template = step(template, rules)
end
freq = template.inject(Hash.new(0)) { |h,v| h[v] += 1; h }.to_a.sort_by(&:last)
puts freq.last.last - freq.first.last

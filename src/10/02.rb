INPUT_FILE = 'inputs/10/01.txt'
# INPUT_FILE = 'inputs/10/example.txt'

# Using hash rocket syntax to avoid symbol/string conversion
BRACKETS = [
  ['(', ')'],
  ['[', ']'],
  ['{', '}'],
  ['<', '>'],
]
OPEN_TO_CLOSED = BRACKETS.to_h
CLOSED_TO_OPEN = BRACKETS.map(&:reverse).to_h
SCORE_MAP = {
  '(' => 1,
  '[' => 2,
  '{' => 3,
  '<' => 4,
}

def score_line(line)
  score = 0
  opening_brackets = []
  line.each_with_index do |char, idx|
    if OPEN_TO_CLOSED[char]
      # opening bracket
      opening_brackets << char
    elsif CLOSED_TO_OPEN[char]
      # invalid closing bracket
      return nil if opening_brackets[-1] != CLOSED_TO_OPEN[char]

      # valid closing bracket
      opening_brackets.pop
    end
  end

  opening_brackets.reverse.reduce(0) do |accum, char|
    accum * 5 + SCORE_MAP[char]
  end
end

lines = File.read(INPUT_FILE).split("\n").map(&:chars)
scores = lines.map { |line| score_line(line) }.compact.sort
puts scores[scores.length / 2]

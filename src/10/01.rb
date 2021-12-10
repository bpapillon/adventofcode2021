INPUT_FILE = 'inputs/10/01.txt'
# INPUT_FILE = 'inputs/10/example.txt'

# Using hash rocket syntax to avoid symbol/string conversion
SCORE_MAP = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137,
}
BRACKET_MAP = {
  ')' => '(',
  '>' => '<',
  ']' => '[',
  '}' => '{',
}

def score_lines(lines)
  lines.reduce(0) { |accum, line| accum + score_line(line) }
end

def score_line(line)
  opening_brackets = []
  line.each_with_index do |char, idx|
    if BRACKET_MAP.values.include?(char)
      # opening bracket
      opening_brackets << char
    elsif BRACKET_MAP.keys.include?(char)
      # invalid closing bracket
      return SCORE_MAP[char] if opening_brackets[-1] != BRACKET_MAP[char]

      # valid closing bracket
      opening_brackets.pop
    end
  end

  0
end

lines = File.read(INPUT_FILE).split("\n").map(&:chars)
puts score_lines(lines)

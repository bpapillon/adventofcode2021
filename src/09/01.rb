INPUT_FILE = 'inputs/09/01.txt'
# INPUT_FILE = 'inputs/09/example.txt'

def get_adjacent(rows, row_idx, char_idx)
  adjacent = []
  adjacent << rows[row_idx - 1][char_idx] if row_idx > 0
  adjacent << rows[row_idx + 1][char_idx] if row_idx < rows.length - 1
  adjacent << rows[row_idx][char_idx - 1] if char_idx > 0
  adjacent << rows[row_idx][char_idx + 1] if char_idx < rows[row_idx].length - 1
  adjacent
end

def is_low_point?(rows, char, row_idx, char_idx)
  adjacent = get_adjacent(rows, row_idx, char_idx)
  adjacent.sort[0] > char
end

def get_risk(rows)
  total_risk = 0
  rows.each_with_index do |row, row_idx|
    row.each_with_index do |char, char_idx|
      total_risk += (char.to_i + 1) if is_low_point?(rows, char, row_idx, char_idx)
    end
  end
  total_risk
end

rows = File.read(INPUT_FILE).split("\n").map(&:chars)
puts get_risk(rows)

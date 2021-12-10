INPUT_FILE = 'inputs/09/01.txt'
# INPUT_FILE = 'inputs/09/example.txt'

def basin_adjacents(rows, row_idx, char_idx)
  adjacent = adjacent_positions(rows, row_idx, char_idx)
  expansion = adjacent.select do |expansion_row, expansion_char|
    expansion_val = rows[expansion_row][expansion_char]
    expansion_val != "9" && expansion_val > rows[row_idx][char_idx]
  end
  expansion + expansion.reduce([]) do |accum, (expansion_row, expansion_char)|
    accum + basin_adjacents(rows, expansion_row, expansion_char)
  end
end

def adjacent_positions(rows, row_idx, char_idx)
  adjacent = []
  adjacent << [row_idx - 1, char_idx] if row_idx > 0
  adjacent << [row_idx + 1, char_idx] if row_idx < rows.length - 1
  adjacent << [row_idx, char_idx - 1] if char_idx > 0
  adjacent << [row_idx, char_idx + 1] if char_idx < rows[row_idx].length - 1
  adjacent
end

def get_basin(rows, row_idx, char_idx)
  adjacent = adjacent_positions(rows, row_idx, char_idx)
  return unless adjacent.map { |x, y| rows[x][y] }.sort[0] > rows[row_idx][char_idx]

  [[row_idx, char_idx]] + basin_adjacents(rows, row_idx, char_idx)
end

def get_basins(rows)
  basins = []
  rows.each_with_index do |row, row_idx|
    row.each_with_index do |_, char_idx|
      basin = get_basin(rows, row_idx, char_idx)
      next if basin == nil

      basins << basin.uniq.length
    end
  end
  basins
end

rows = File.read(INPUT_FILE).split("\n").map(&:chars)
basins = get_basins(rows)
puts basins.sort[-3..-1].reduce(:*)

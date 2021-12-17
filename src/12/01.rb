INPUT_FILE = 'inputs/12/01.txt'
# INPUT_FILE = 'inputs/12/example.txt'

class String
  def is_lower?
    self == self.downcase
  end
end

class Cave
  attr_reader :cave_map, :paths

  def initialize(filename)
    @cave_map = generate_map(filename)
    @paths = []
    find_paths(['start'])
  end

  def generate_map(filename)
    File.read(filename).split("\n").reduce({}) do |accum, line|
      a, b = line.split('-')
      accum[a] ||= []
      accum[a] << b
      accum[b] ||= []
      accum[b] << a
      accum
    end
  end

  def find_paths(path)
    last_cave = path[-1]
    if last_cave == 'end'
      @paths << path
      return
    end

    next_caves = cave_map[last_cave].reject do |cave|
      cave.is_lower? && path.include?(cave)
    end
    return if next_caves.empty?

    next_caves.each do |next_cave|
      find_paths(path + [next_cave])
    end
  end
end

puts Cave.new(INPUT_FILE).paths.count

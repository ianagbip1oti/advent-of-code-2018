

Point = Struct.new(:x, :y) do
  def manhattan_distance(other)
    (x - other.x).abs + (y - other.y).abs
  end

  def find_nearest(ps)
    distances = Hash.new { |hsh, p| hsh[p] = manhattan_distance p }

    nearest = ps.min_by(&distances)

    return nil if distances.values.count(distances[nearest]) > 1

    nearest
  end

  def sum_distances(ps)
    ps.map { |p| manhattan_distance p }.sum
  end

  def self.parse(s)
    Point.new *s.split(',').map(&:to_i)
  end
end

INPUT = DATA.each_line.map { |l| Point.parse l }

def part1
  grid = Array.new(400) { Array.new(400) { nil }}

  grid.each.each_with_index do |row, x|
    row.each_with_index do |cell, y|
      grid[x][y] = Point.new(x, y).find_nearest INPUT
    end
  end

  counts = grid.flatten.group_by(&:itself).transform_values(&:size)

  counts.delete nil

  grid[0].each { |p| counts.delete p }
  grid[399].each { |p| counts.delete p }
  grid.map { |r| r[0] }.flatten.each { |p| counts.delete p }
  grid.map { |r| r[399] }.flatten.each { |p| counts.delete p }

  p counts.values.max
end

def part2

  grid = Array.new(400) { Array.new(400) { nil }}

  grid.each.each_with_index do |row, x|
    row.each_with_index do |cell, y|
      grid[x][y] = Point.new(x, y).sum_distances INPUT
    end
  end

  p grid.flatten.count { |d| d < 10000 }
end

part1
part2

__END__
357, 59
312, 283
130, 47
89, 87
87, 58
158, 169
182, 183
300, 318
82, 257
200, 194
71, 259
112, 67
82, 163
107, 302
58, 194
40, 88
288, 339
64, 245
243, 302
41, 43
147, 276
143, 116
103, 178
262, 226
253, 157
313, 71
202, 236
353, 192
96, 74
167, 50
125, 132
90, 315
174, 232
185, 237
126, 134
152, 191
104, 315
283, 90
95, 193
252, 286
48, 166
69, 75
48, 349
59, 124
334, 95
263, 134
50, 314
196, 66
342, 221
60, 217

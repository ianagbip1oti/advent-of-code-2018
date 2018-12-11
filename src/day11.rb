
SERIAL_NUMBER = 4842

def power(x, y, serial=SERIAL_NUMBER)
  rack_id = x + 10
  power = y * rack_id
  power += serial
  power = power*=rack_id
  power = power < 100 ? 0 : power.to_s[-3].to_i
  power -= 5
  power
end

def build_grid
  grid = Array.new(301) { Array.new(301) { 0 } }

  (1..300).each do |x|
    (1..300).each do |y|
      grid[x][y] = power x, y
    end
  end

  grid
end

def part1
  grid = build_grid

  cells = {} 
  (1..298).each do |x|
    (1..298).each do |y|
      power = grid[x][y,3].sum + grid[x+1][y,3].sum + grid[x+2][y,3].sum
      cells[[x,y]] = grid[x,3].map { |row| row[y,3].sum }.sum
    end
  end

  p cells.keys.max_by(&cells)
end

def part2
  grid = build_grid

  cells = {} 

  (1..300).each do |x|
    (1..300).each do |y|

      power = 0

      (1..(300 - [x, y].max)).each do |size|
        next if [x,y].max + size > 300

        power += grid[x+size-1][y,size].sum
        power += grid[x,size].map { |row| row[y+size-1] }.sum
        power -= grid[x+size-1][y+size-1]
        cells[[x,y,size]] = power
      end
    end
  end

  p cells.keys.max_by(&cells)
end

part1
part2


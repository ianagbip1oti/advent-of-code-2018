require 'set'

def changes
  IO.readlines("#{__dir__}/day1input.txt").map(&:to_i)
end

def part1
  p changes.sum
end

def part2
  freq = 0
  seen = Set.new [freq]

  changes.cycle.each do |change|
    freq += change
    unless seen.add?(freq)
      p freq
      break
    end
  end
end

part1
part2


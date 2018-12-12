require 'set'

INITIAL_STATE = '####....#...######.###.#...##....#.###.#.###.......###.##..##........##..#.#.#..##.##...####.#..##.#'

RULES = DATA.map { |l| l.split('=>').map(&:strip) }.to_h

def pretty_print(state)
  min, max = state.keys.minmax

  (min..max).each do |idx|
    print state[idx] || '.'
  end
  puts
end

def generate(generations)
  state = INITIAL_STATE.chars.each_with_index.select { |p, i| p == '#' }.map(&:last).to_a

  diffs = [nil] * 10

  done = 1.step do |step|
    new_state = []

    min, max = state.minmax

    ((min-2)..(max+2)).each do |idx|
      rule = (-2..2).map { |r| state.include?(idx + r) ? '#' : '.' }.join

      new_state << idx if RULES[rule] == '#'
    end

    diffs.shift
    diffs << new_state.sum - state.sum
    state = new_state

    break step if diffs.uniq.size == 1 || step == generations
  end

  p state.sum + diffs[0] * (generations - done)
end

def part1
  generate 20
end

def part2
  generate 50000000000
end

part1
part2


__END__
..#.. => .
#.#.# => #
#.### => #
.##.. => .
#.#.. => #
.#.#. => #
.###. => #
.#### => #
##... => #
#.##. => #
#..## => #
....# => .
###.# => .
##### => #
..... => .
..#.# => .
.#... => #
##.#. => .
.#.## => #
..##. => .
#...# => .
##.## => #
...#. => .
#..#. => .
..### => .
.##.# => .
#.... => .
.#..# => #
####. => .
...## => #
##..# => .
###.. => .

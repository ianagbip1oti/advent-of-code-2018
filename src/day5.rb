
INPUT = IO.read("#{__dir__}/day5input.txt").strip

def reduce(s)
  head, *tail = *s.chars

  stk = [head]

  tail.each do |s|
    if s.swapcase == stk.last
      stk.pop
    else
      stk.push s
    end
  end

  stk
end


def part1
  p reduce(INPUT).size
end

def part2
  p ('a'..'z').
    map { |l| INPUT.delete "#{l}#{l.upcase}" }.
    map { |l| reduce(l).size }.
    min
end

part1
part2


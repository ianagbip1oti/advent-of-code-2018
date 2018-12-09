
class CircularZipper
  attr_accessor :left, :current, :right

  def initialize(n)
    @left = []
    @right = []
    @current = n
  end

  def insert(n)
    right.unshift current
    @current = n
  end

  def remove
    @left, @right = [], left if right.empty?
    @current = right.shift
  end

  def clockwise
    left << current
    @left, @right = [], left if right.empty?
    @current = right.shift
  end

  def counter_clockwise
    right.unshift current
    @left, @right = right, [] if left.empty?
    @current = left.pop
  end
end

def play(players, marbles)
  scores = [ 0 ] * players

  board = CircularZipper.new 0
  board.insert 1

  (2..marbles).each do |m|
    if m % 23 == 0
      scores[m % players] += m
      7.times { board.counter_clockwise }
      scores[m % players] += board.current
      board.remove
    else
      2.times { board.clockwise }
      board.insert m
    end
  end

  scores.max
end

def part1
  p play(431, 70950)
end

def part2
  p play(431, 7095000)
end

part1
part2






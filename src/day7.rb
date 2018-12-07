
INPUT = DATA.map do |line|
  line.match(/Step (\w+) must be finished before step (\w+) can begin\./).captures
end.to_a

def dependency_graph
  deps = Hash.new { |h, k| h[k] = [] }

  INPUT.each do |i|
    v, k = *i
    deps[k] << v
    deps[v]
  end

  deps
end

def part1
  deps = dependency_graph

  order = ''

  while !deps.empty?
    n = deps.select { |k, v|  v.empty? }.keys.sort.first
    order << n
    deps.delete n
    deps.transform_values! { |v| v.delete(n); v }
  end

  p order
end

def task_length(t)
  61 + t.ord - ?A.ord
end

def print_tasks(ms)
  i = 0
  ms.each do |m|
    p "#{i}: #{m.join}" unless m.empty?
    i += 1
  end
end

def part2
  minutes = Array.new(1000) { [] }

  deps = dependency_graph

  minute = 0

  complete_at = {}

  while !deps.empty?
    tasks = deps.select { |k, v| v.empty? && !minutes[minute].include?(k) }.keys.sort

    tasks.each do |t|
      if minutes[minute].size < 5
        (minute..minute + task_length(t) - 1).each do |idx|
          minutes[idx] << t
        end
        complete_at[t] = minute + task_length(t) - 1
      end
    end
    minute += 1

    complete_at.select { |k, v| v < minute }.keys.each do |t| 
      deps.delete(t)
      deps.transform_values! { |v| v.delete(t); v }
    end
  end

  p minute
end

part1
part2

__END__
Step C must be finished before step P can begin.
Step V must be finished before step Q can begin.
Step T must be finished before step X can begin.
Step B must be finished before step U can begin.
Step Z must be finished before step O can begin.
Step P must be finished before step I can begin.
Step D must be finished before step G can begin.
Step A must be finished before step Y can begin.
Step R must be finished before step O can begin.
Step J must be finished before step E can begin.
Step N must be finished before step S can begin.
Step X must be finished before step H can begin.
Step F must be finished before step L can begin.
Step S must be finished before step I can begin.
Step W must be finished before step Q can begin.
Step H must be finished before step K can begin.
Step K must be finished before step Q can begin.
Step E must be finished before step L can begin.
Step Q must be finished before step O can begin.
Step U must be finished before step G can begin.
Step L must be finished before step O can begin.
Step Y must be finished before step G can begin.
Step G must be finished before step I can begin.
Step M must be finished before step I can begin.
Step I must be finished before step O can begin.
Step A must be finished before step N can begin.
Step H must be finished before step O can begin.
Step T must be finished before step O can begin.
Step H must be finished before step U can begin.
Step A must be finished before step I can begin.
Step B must be finished before step R can begin.
Step V must be finished before step T can begin.
Step H must be finished before step M can begin.
Step C must be finished before step A can begin.
Step B must be finished before step G can begin.
Step L must be finished before step Y can begin.
Step T must be finished before step J can begin.
Step A must be finished before step R can begin.
Step X must be finished before step L can begin.
Step B must be finished before step L can begin.
Step A must be finished before step F can begin.
Step K must be finished before step O can begin.
Step W must be finished before step M can begin.
Step Z must be finished before step N can begin.
Step Z must be finished before step S can begin.
Step R must be finished before step K can begin.
Step Q must be finished before step L can begin.
Step G must be finished before step O can begin.
Step F must be finished before step Y can begin.
Step V must be finished before step H can begin.
Step E must be finished before step I can begin.
Step W must be finished before step Y can begin.
Step U must be finished before step I can begin.
Step F must be finished before step K can begin.
Step M must be finished before step O can begin.
Step Z must be finished before step H can begin.
Step X must be finished before step S can begin.
Step J must be finished before step O can begin.
Step B must be finished before step I can begin.
Step F must be finished before step H can begin.
Step D must be finished before step U can begin.
Step E must be finished before step M can begin.
Step Z must be finished before step X can begin.
Step P must be finished before step L can begin.
Step W must be finished before step H can begin.
Step C must be finished before step D can begin.
Step A must be finished before step X can begin.
Step Q must be finished before step I can begin.
Step R must be finished before step Y can begin.
Step B must be finished before step A can begin.
Step N must be finished before step L can begin.
Step H must be finished before step G can begin.
Step Y must be finished before step M can begin.
Step L must be finished before step G can begin.
Step G must be finished before step M can begin.
Step Z must be finished before step R can begin.
Step S must be finished before step Q can begin.
Step P must be finished before step J can begin.
Step V must be finished before step J can begin.
Step J must be finished before step I can begin.
Step J must be finished before step X can begin.
Step W must be finished before step O can begin.
Step B must be finished before step F can begin.
Step R must be finished before step M can begin.
Step V must be finished before step S can begin.
Step H must be finished before step E can begin.
Step E must be finished before step U can begin.
Step R must be finished before step W can begin.
Step X must be finished before step Q can begin.
Step N must be finished before step G can begin.
Step T must be finished before step I can begin.
Step L must be finished before step M can begin.
Step H must be finished before step I can begin.
Step U must be finished before step M can begin.
Step C must be finished before step H can begin.
Step P must be finished before step H can begin.
Step J must be finished before step F can begin.
Step A must be finished before step O can begin.
Step X must be finished before step M can begin.
Step H must be finished before step L can begin.
Step W must be finished before step K can begin.

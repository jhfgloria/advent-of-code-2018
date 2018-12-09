class Step
  attr_reader :id
  attr_reader :depends_on
  attr_reader :dependencies

  def initialize(id)
    @id = id
    @depends_on = []
    @dependencies = []
  end

  def add_dependency(dependency_id)
    @dependencies << dependency_id
  end

  def add_depends_on(depends_id)
    @depends_on << depends_id
  end
end

steps = { }
File.open("input.txt").each do |line|
  from = line[5]; to = line[36];
  steps[from] = Step.new(from) if !steps.has_key? from
  steps[to] = Step.new(to) if !steps.has_key? to

  steps[from].add_dependency to
  steps[to].add_depends_on from
end

starter_steps = steps.select do |key, value|
  value.depends_on.empty?
end

processed = [] << starter_steps.keys.sort.first
processing = []
processed.each { |key| processing.concat(starter_steps.keys.sort[1..-1]).concat(steps[key].dependencies).uniq }
processing.sort!

while !processing.empty? do
  processing.each do |p|
    if (steps[p].depends_on & processed).length == steps[p].depends_on.length then
      processed << p
      processing.delete(p)
      processing = processing.concat(steps[p].dependencies).uniq.sort!
      break
    end
  end
end

puts processed.join('')
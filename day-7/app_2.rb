EXTRA_SECONDS = 60
NUMBER_OF_WORKERS = 5

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

class Worker
  attr_reader :is_busy
  attr_reader :time_busy

  def initialize
    @is_busy = false
    @time_busy = 0
    @work_id = -1
  end

  def add_work(work_id)
    @time_busy = work_id.ord - 64 + EXTRA_SECONDS
    @is_busy = true
    @work_id = work_id
  end

  def remove_work
    current_work = @work_id
    @work_id = -1
    return current_work
  end

  def decrement_busy_time
    @time_busy -= 1
    @is_busy = false if @time_busy == 0
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

workers = []
# Initializing workers
for i in 0...NUMBER_OF_WORKERS do
  workers << Worker.new
end

queued = [].concat(starter_steps.keys)
processed = []
processing = []
queued.sort!

# Exercise is counting second zero as unit of work
seconds_spent = -1
while processed.length != steps.keys.length do
  # Workers performing work
  workers.each_with_index do |worker, id|
    worker.decrement_busy_time()
    if !worker.is_busy then
      work = worker.remove_work
      next if work == -1
      processed << work
      processing.delete work
      queued = queued.concat(steps[work].dependencies).uniq.sort!
    end
  end

  # Assigning work to non busy workers
  queued.each do |work|
    if (steps[work].depends_on & processed).length == steps[work].depends_on.length then
      workers.each_with_index do |worker, id|
        if !worker.is_busy then
          processing << work
          processing.sort!
          worker.add_work work
          break
        end
      end
    end
  end

  # Remove started works from queued
  queued = (queued - processing).sort!

  seconds_spent += 1
end

puts seconds_spent
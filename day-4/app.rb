require "date"

class Log 
  def initialize(date, log)
    @date = date
    @log = log
  end

  def date
    @date
  end

  def log
    @log
  end

  def print
    "#{@date} #{@log}"
  end
end

logs = []
File.open("input.txt").each do |line|
  date = DateTime.strptime(line[line.index('[') + 1, line.index(']')], '%Y-%m-%d %H:%M')
  log = line[line.index(']') + 2, line.length].strip
  logs << Log.new(date, log)
end

logs.sort! do |log_1, log_2|
  log_1.date - log_2.date
end

current_guard = 0
sleeped = 0
woke = 0
shifts = { }
minutes_sleeping = { }

logs.each do |log|
  if current_guard != 0 && !(shifts.has_key? current_guard) then
    shifts[current_guard] = Array.new(60, 0)
    minutes_sleeping[current_guard] = 0
  end

  if log.log.eql? "falls asleep" then
    sleeped = log.date.strftime('%M').to_i
  elsif log.log.eql? "wakes up" then
    woke = (log.date.strftime('%M').to_i) -1
    for i in sleeped..woke do
      shifts[current_guard][i] += 1
    end
    minutes_sleeping[current_guard] += (woke - sleeped)
  else
    current_guard = log.log[log.log.index('#') + 1, log.log.index(" b") - 6].to_i
  end
end

top_agent = 0
top_minutes = 0
minutes_sleeping.keys.each do |key|
  if minutes_sleeping[key] > top_minutes then 
    top_minutes = minutes_sleeping[key]
    top_agent = key
  end
end

puts "Top agent: #{top_agent}"
top_minute = 0
top_position = 0
for i in 0..59 do
  if shifts[top_agent][i] > top_minute then
    top_minute = shifts[top_agent][i]
    top_position = i
  end
end

puts "Top minute: #{top_position}"
puts "Strategy one result: #{top_agent * top_position}"

top_agent = 0
top_minute = 0
top_position = 0
shifts.keys.each do |key|
  for i in 0..59 do
    if shifts[key][i] > top_minute then
      top_agent = key
      top_minute = shifts[top_agent][i]
      top_position = i
    end
  end
end

puts "Strategy two result: #{top_agent * top_position}"
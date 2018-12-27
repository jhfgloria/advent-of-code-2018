GENERATIONS = 20

initial_state = nil
notes = { }
zero_reference = 0

File.open("input.txt").each_with_index do |line, index|
  if index == 0 then
    matches = line.scan(/[#.]+/)
    initial_state = '.' * matches[0].length + matches[0] + '.' * matches[0].length
    zero_reference = matches[0].length
  elsif index > 1
    matches = line.scan(/[#.]+/)
    notes[matches[0]] = matches[1] 
  end
end

puts initial_state

for generation in 1..GENERATIONS do
  new_plant_pots = {}
  notes.keys.each do |pattern|
    start_of_search = 0
    while index = initial_state.index(pattern, start_of_search) do
      start_of_search = index + 1
      new_plant_pots[index + 2 - zero_reference] = notes[pattern]
    end
  end

  initial_state.each_char.with_index do |character, index|
    if new_plant_pots.keys.include?(index - zero_reference) then
      initial_state[index] = new_plant_pots[index - zero_reference]
    else
      initial_state[index] = '.'
    end
  end

  puts "#{generation}: #{initial_state}"
end

sum = 0
initial_state.each_char.with_index do |character, index|
  if character == '#' then
    sum += index - zero_reference
  end
end

puts sum

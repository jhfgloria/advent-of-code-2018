GENERATIONS = 161

initial_state = nil
notes = { }
zero_reference = 0

File.open("input.txt").each_with_index do |line, index|
  if index == 0 then
    matches = line.scan(/[#.]+/)
    initial_state = '.' * 4 + matches[0] + '.' * matches[0].length * 2
    zero_reference = 4
  elsif index > 1
    matches = line.scan(/[#.]+/)
    notes[matches[0]] = matches[1] 
  end
end

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
end

sum = 0
initial_state.each_char.with_index do |character, index|
  if character == '#' then
    # Read notes.txt to understand why I did this
    sum += (index - zero_reference + (50000000000-GENERATIONS))
  end
end

puts sum

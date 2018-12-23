serial_number = 0
File.open('input.txt').each do |line|
  serial_number = line.to_i
end

class FuelCell
  attr_reader :value

  def initialize(x, y, serial_number)
    @id = x + 10
    @serial_number = serial_number
    @value = calc_value(@id, y, serial_number)
  end

private
  def calc_value(id, y, serial_number)
    step_1 = id * y
    step_2 = step_1 + serial_number
    step_3 = step_2 * id
    step_4 = (step_3 / 100) % 10
    return step_4 - 5
  end
end

cell_grid = Array.new(300) { Array.new(300, nil) }

for i in 0...300 do
  for j in 0...300 do
    cell_grid[i][j] = FuelCell.new(i + 1, j + 1, serial_number)
  end
end

max_value_section = 0
max_value_section_top_left_position = {}
max_value_section_size = 0
# Iterate through columns
for i in 34..299 do
  # Iterate through lines
  for j in 72..299 do
    # Test every possible square
    for size_of_square_side in 0..299-[i, j].max
      value_section = 0
      
      for x in 0..size_of_square_side
        for y in 0..size_of_square_side
          value_section += cell_grid[i+x][j+y].value
        end
      end
      
      if value_section > max_value_section then
        max_value_section = value_section
        max_value_section_top_left_position = { x: i + 1, y: j + 1 }
        max_value_section_size = size_of_square_side + 1
      end
    end
  end
end

puts max_value_section, max_value_section_top_left_position, max_value_section_size

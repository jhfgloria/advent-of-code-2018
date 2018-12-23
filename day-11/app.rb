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
for i in 0..297 do
  for j in 0..297 do
    section_value = cell_grid[i][j].value + cell_grid[i][j+1].value + cell_grid[i][j+2].value +
                    cell_grid[i+1][j].value + cell_grid[i+1][j+1].value + cell_grid[i+1][j+2].value +
                    cell_grid[i+2][j].value + cell_grid[i+2][j+1].value + cell_grid[i+2][j+2].value 
    if section_value > max_value_section then
      max_value_section = section_value
      max_value_section_top_left_position = { x: i + 1, y: j + 1 }
    end
  end
end

puts max_value_section, max_value_section_top_left_position
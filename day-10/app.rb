class Star
  def initialize(pos_x, pos_y, vel_x, vel_y)
    @pos_x = pos_x
    @pos_y = pos_y
    @vel_x = vel_x
    @vel_y = vel_y
  end

  def move(time = 1)
    @pos_x = (@pos_x + (@vel_x * time)).round
    @pos_y = (@pos_y + (@vel_y * time)).round
  end

  def position
    return { x: @pos_x, y: @pos_y }
  end

  def distance(neighbour_star)
    neighbour_star_position = neighbour_star.position()
    return Math.sqrt((@pos_x - neighbour_star_position[:x])**2+(@pos_y - neighbour_star_position[:y])**2)
  end
end

def clear_sky(stars)
  x_max = 0; x_min = 0;
  y_max = 0; y_min = 0;

  stars.each do |star|
    current_star_position = star.position()
    x_max = current_star_position[:x] if current_star_position[:x] > x_max
    x_min = current_star_position[:x] if current_star_position[:x] < x_min
    y_max = current_star_position[:y] if current_star_position[:y] > y_max
    y_min = current_star_position[:y] if current_star_position[:y] < y_min
  end

  sky_width = x_max.abs + x_min.abs + 1
  sky_height = y_max.abs + y_min.abs + 1
  zero_ref_x = sky_width - x_max.abs - 1
  zero_ref_y = sky_height - y_max.abs - 1

  return {
    map: Array.new(sky_height) { Array.new(sky_width, '.') },
    height: sky_height,
    width: sky_width,
    zero: {
      x: zero_ref_x,
      y: zero_ref_y
    }
  }
end

stars = []
File.open("input.txt").each do |line|
  pos_x = line[10, line.index(',')].to_i
  pos_y = line[line.index(',') + 1, line.index('>')].to_i
  vel_x = line[line.index('<', line.index('>')) + 1, line.index(',', line.index('>'))].to_i
  vel_y = line[line.index(',', line.index('>')) + 1, line.index('>', line.index(',', line.index('>')))].to_i
  stars << Star.new(pos_x, pos_y, vel_x, vel_y)
end

# Find when do all stars aligned
seconds = 0
loop do
  close_stars = stars.select do |star|
    is_close = false
    stars.each do |neighbour_star|
      next if neighbour_star.object_id == star.object_id
      if star.distance(neighbour_star) <= 2 then
        is_close = true
        break
      end
    end
    is_close
  end
  
  break if close_stars.length == stars.length
  
  seconds += 1
  stars.each do |star|
    star.move
  end
end

puts "Stars aligned in #{seconds} seconds"

sky = clear_sky(stars)

stars.each do |star|
  positions = star.position()
  real_positions_x = positions[:x] + sky[:zero][:x] > sky[:width] - 1 ? sky[:width] - 1 - positions[:x] + sky[:zero][:x] : positions[:x] + sky[:zero][:x]
  real_positions_y = positions[:y] + sky[:zero][:y] > sky[:height] - 1 ? sky[:height] - 1 - positions[:y] + sky[:zero][:y] : positions[:y] + sky[:zero][:y]
  sky[:map][real_positions_y][real_positions_x] = '#'
end

for i in 0...sky[:height] do
  for j in 0...sky[:width] do
    print("#{sky[:map][i][j]} ")
  end
  puts()
end

class Coordinate
  attr_reader :id
  attr_reader :x
  attr_reader :y
  attr_accessor :area
  attr_accessor :infinite

  def initialize(id, x, y)
    @id = id
    @x = x; @y = y
    @infinite = false
    @area = 0
  end

  def distance_to_coordinate(coordinate)
    (@x-coordinate.x).abs + (@y-coordinate.y).abs
  end

  def show
    "id: #{@id} x: #{@x} y: #{@y} area: #{@area} infinite: #{@infinite}"
  end
end

coordinates = []
File.open("input.txt").each do |line|
  x = line[0, line.index(',')].to_i
  y = line[line.index(',')+1, line.length-1].to_i
  coordinates << Coordinate.new(coordinates.length, x, y)
end

def calc_map_size(coordinates)
  map_width = 0
  map_height = 0

  coordinates.each do |coordinate|
    if coordinate.x > map_width then
      map_width = coordinate.x
    end
  
    if coordinate.y > map_height then
      map_height = coordinate.y
    end
  end

  { :width => map_width + 1, :height => map_height + 1 }
end

def find_nearest_coordinate(coordinates, target_coordinate)
  nearest_distance = 1000000
  nearest_coordinate = nil
  coordinates.each do |c|
    if c.x == target_coordinate.x && c.y == target_coordinate.y then
      nearest_coordinate = c
      break
    end

    distance = c.distance_to_coordinate(target_coordinate)

    if distance == nearest_distance then
      nearest_coordinate = nil
    elsif distance < nearest_distance then
      nearest_distance = distance
      nearest_coordinate = c
    end
  end

  return nearest_coordinate
end

map_size = calc_map_size coordinates
map = Array.new(map_size[:height]) do Array.new(map_size[:width], -1) end

for i in 0..map_size[:height]-1 do
  for j in 0..map_size[:width]-1 do
    nearest = find_nearest_coordinate(coordinates, Coordinate.new(-1, j, i))
    map[i][j] = nearest.id if nearest != nil
  end
end

for i in 0..map_size[:height]-1 do
  for j in 0..map_size[:width]-1 do
    id_in_position = map[i][j]
    next if id_in_position == -1

    coordinate = (coordinates.select { |c| c.id == id_in_position })[0]
    coordinate.area += 1
    
    if i == 0 || i == map_size[:height]-1 || j == 0 || j == map_size[:width]-1 then
      coordinate.infinite = true
    end
  end
end

max_finite_area = 0
coordinates.each do |c|
  infinite_area = c.area * (c.infinite ? 0 : 1)
  if infinite_area > max_finite_area then
    max_finite_area = infinite_area
  end
end

puts max_finite_area

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

map_size = calc_map_size coordinates
map = Array.new(map_size[:height]) do Array.new(map_size[:width], -1) end

MAX_DISTANCE = 10000
region_size = 0
for i in 0..map_size[:height]-1 do
  for j in 0..map_size[:width]-1 do
    distance_sum = 0

    coordinates.each do |c|
      distance_sum += c.distance_to_coordinate(Coordinate.new(-1, j, i))
      break if distance_sum >= MAX_DISTANCE
    end

    if distance_sum < MAX_DISTANCE then
      region_size += 1
    end
  end
end

puts region_size
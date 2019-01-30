class Cart
  attr_accessor :direction
  attr_accessor :x
  attr_accessor :y

  def initialize(x, y, direction)
    @x = x
    @y = y
    @direction = direction
    @turn = 'l'
  end

  def move
    case @direction
    when 'v'
      change_location(0, 1)
    when '^'
      change_location(0, -1)
    when '>'
      change_location(1, 0)
    when '<'
      change_location(-1, 0)
    end
  end

  def show
    print "x: #{@x} y: #{@y} d: #{@direction}"
  end

  def crashed?(all_carts)
    all_carts.each do |other|
      next if other.object_id == self.object_id
      if other.x == @x && other.y == @y
        return true, { x: x + 1, y: y + 1 }
      end
    end

    return false
  end
private
  def change_location(delta_x, delta_y)
    @x = delta_x + @x
    @y = delta_y + @y
  end
end

lines = []
carts = []
File.open("input.txt").each_with_index do |line, y|
  lines << line
  line.each_char.with_index do |char, x|
    if char == '<' || char == '>' || char == '^' || char == 'v'
      carts << Cart.new(x, y, char)
    end
  end
end

# width = (lines.max).length
# height = lines.length

carts.each do |cart|
  puts cart.show
end

#while true
  carts.each do |cart|
    cart.move()
    # Crash test
    carts.each do |other|
      next if other.object_id == cart.object_id
      if other.x == cart.x && other.y == cart.y
        return { x: x + 1, y: y + 1 }
      end
    end
    # Calculate new direction
  end
#end

carts.each do |cart|
  puts cart.show
end

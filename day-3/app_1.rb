class Claim
  def initialize(id, left, top, width, height)
    @id = id
    @left = left
    @top = top
    @width = width
    @height = height
  end

  def id
    @id
  end

  def left
    @left
  end

  def top
    @top
  end

  def width
    @width
  end

  def height
    @height
  end

  def toString
    "id: #{@id} left: #{@left} top: #{@top} width: #{@width} height: #{@height}"
  end
end

claims = []
fabric_width = 0
fabric_height = 0

File.open('input.txt').each do |line|
  id = line[line.index('#') + 1, line.index('@')].to_i
  left = line[line.index('@') + 2, line.index(',')].to_i
  top = line[line.index(',') + 1, line.index(':')].to_i
  width = line[line.index(':') + 2, line.index('x')].to_i
  height = line[line.index('x') + 1, line.length].to_i
  claims << Claim.new(id, left, top, width, height)
  
  if (fabric_width < (left + width)) then
    fabric_width = left + width
  end

  if (fabric_height < (top + height)) then
    fabric_height = top + height
  end
end

fabric = Array.new(fabric_width+1) do Array.new(fabric_height+1, 0) end

claims.each do |claim|
  for i in claim.left()..claim.left()+claim.width()-1 do
    for j in claim.top()..claim.top()+claim.height()-1 do
      fabric[j][i] += 1
    end
  end
end

clashes = 0
for i in 0..fabric_width-1 do
  for j in 0..fabric_height-1 do
    if fabric[j][i] > 1 then
      clashes += 1
    end
  end
end
puts clashes
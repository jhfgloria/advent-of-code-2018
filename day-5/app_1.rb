polymer = ""
File.open("input.txt").each do |line|
  polymer = line.split('')
end

def reaction(polymer)
  copy = polymer.dup
  for i in 0..copy.length-2 do
    if (copy[i].ord - copy[i+1].ord).abs == 32 then
      # Remove two consecutive types 
      copy.delete_at i
      copy.delete_at i
      return copy
    end
  end
  return polymer
end

reacting = true

while reacting do
  product = reaction(polymer)
  if (product.join('') != polymer.join('')) then
    polymer = product
  else
    reacting = false
  end
end


puts polymer.length
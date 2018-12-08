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

def isolate_type(polymer, type)
  polymer.select { |t| t if t.downcase != type }
end

lower_polimer_size = polymer.length

for c in 'a'..'z' do
  polymer_wout_type = isolate_type(polymer, c)
  reacting = true

  while reacting do
    product = reaction(polymer_wout_type)

    if (product.join('') != polymer_wout_type.join('')) then
      polymer_wout_type = product
    else
      reacting = false

      if product.length < lower_polimer_size then
        lower_polimer_size = product.length
      end
    end
  end
end

puts lower_polimer_size
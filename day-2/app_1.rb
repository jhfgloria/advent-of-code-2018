pairs = 0
triples = 0

File.open('input.txt').each do |line|
  map = {}
  line.split('').each do |letter|
    if map.include?(letter) then
      map[letter] = map[letter] + 1
    else 
      map[letter] = 1
    end
  end
  
  if map.has_value?(2) then 
    pairs = pairs + 1
  end

  if map.has_value?(3) then 
    triples = triples + 1
  end
end

puts pairs * triples
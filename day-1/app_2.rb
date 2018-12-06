sum = 0
arr = [sum]
twice = false

while !twice do
  # reading the file once into a variable and calling 
  # each on that variable was only looping through the
  # lines once... Need to check why!?!
  File.open('input.txt').each do |frequency|
    sum += frequency.to_i
    if arr.include?(sum)
      twice = true
      break
    end
    arr << sum
  end
end
puts sum
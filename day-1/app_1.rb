sum = 0
# The directory from where ruby relates the open
# argument is the directory from where ruby interpreter
# is run and not the the running file's.
# Need to check why and what can I do!! 
File.open('input.txt').each do |frequency|
  sum += frequency.to_i
end
puts sum
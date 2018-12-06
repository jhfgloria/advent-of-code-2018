tags_arr = Array.new
main_tag = nil
secondary_tag = nil

File.open('input.txt').each do |tag|
  tags_arr << tag
end

for i in 0..tags_arr.size()-1 do
  differences = 0
  main_tag_arr = tags_arr[i].split('')

  for j in 0..tags_arr.size()-1 do
    next if tags_arr[i].eql?(tags_arr[j])

    differences = 0
    secondary_tag_arr = tags_arr[j].split('')

    
    for k in 0..main_tag_arr.size()-1 do
      if secondary_tag_arr[k] != main_tag_arr[k] then
        differences += 1
      end
    end

    if differences == 1 then 
      main_tag = tags_arr[i]
      secondary_tag = tags_arr[j]
      break
    end
  end

  break if differences == 1
end

goal_tag = []
main_tag_arr = main_tag.split('')
secondary_tag_arr = secondary_tag.split('')

for i in 0..main_tag_arr.size()-1 do
  if main_tag_arr[i] == secondary_tag_arr[i] then
    goal_tag << main_tag_arr[i]
  end
end

puts goal_tag.join('')

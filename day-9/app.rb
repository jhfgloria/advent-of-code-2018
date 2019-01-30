n_players = 0
marbles = 0
File.open('input.txt').each do |line|
  args = line.split(':')
  n_players = args[0].to_i
  marbles = args[1].to_i
end

players = {}

for player in 1..n_players do
  players[player] = 0
end

board = [0]
current = 0
current_player = 1

for marble in 1..marbles do
  booleano = true
  if marble % 23 == 0 then
    current -= 7
    deleted = board.delete_at(current)
    # puts "current position: #{current} current player #{current_player} current score: #{players[current_player]}; deleted: #{deleted}; marble: #{marble}"
    players[current_player] += (deleted + marble)
    current_player = (current_player == n_players) ? 1 : current_player + 1
    next
  end 
  
  if current + 1 == board.length - 1 then
    current = board.length
  elsif current + 1 == board.length then
    current = 1
  else
    current = current + 2
  end
  
  board = board.insert(current, marble)
  current_player = (current_player == n_players) ? 1 : current_player + 1
end

puts players.values.max
puts players
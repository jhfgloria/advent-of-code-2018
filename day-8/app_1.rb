class Node
  attr_reader :metadata
  attr_reader :children

  def initialize()
    @children = []
    @metadata = []
  end

  def add_child(node)
    @children << node
  end

  def add_metadata(metadata)
    @metadata.concat(metadata)
  end
end

input = nil
File.open("input.txt").each do |line|
  input = line.split(" ").map do |item| item.to_i end
end

def build_tree(node, input)
  if (input.nil? || input.empty?) then
    return node
  elsif (input[0] == 0) then
    new_input = input.slice(2 + input[1], input.length)
    new_node = Node.new()
    new_node.add_metadata(input[2, input[1]])
    return new_node, new_input
  else
    new_node = Node.new()
    number_of_children = input[0]
    number_of_metadata = input[1]
    new_input = input.slice(2, input.length)
    for i in 0...number_of_children do
      iteration_node, iteration_input = build_tree(new_node, new_input)
      new_node.add_child(iteration_node)
      new_input = iteration_input
    end
    new_node.add_metadata(new_input[0, number_of_metadata])
    return new_node, new_input.slice(number_of_metadata, new_input.length)
  end
end

new_node, new_input = build_tree(nil, input)

def tree_metadata_sum(node)
  if (node.children.empty?) then
    return node.metadata.reduce(:+)
  else
    sum = node.metadata.reduce(:+) || 0
    for i in 0...node.children.length
      sum += tree_metadata_sum(node.children[i])
    end
    return sum
  end
end

def alternative_tree_root_metadata_sum(node)
  if node.children.empty? then
    return node.metadata.reduce(:+) || 0
  else
    sum = 0
    node.metadata.each do |index|
      if !node.children[index-1].nil?
        sum += alternative_tree_root_metadata_sum(node.children[index-1])
      end
    end
    return sum
  end
end

puts tree_metadata_sum(new_node)
puts alternative_tree_root_metadata_sum(new_node)
